use v6;

# Script that builds the http://perl.pt website
# Visit https://github.com/APPP/perl.pt for more information

use Pekyll;
use Pekyll::Routers;
use Pekyll::Compilers;

use Template6;
use Syndication;

my $t6 = Template6.new;
$t6.add-path: 'src';
$t6.add-path: 'templates';
my %posts;

my %rules = (
    'assets/*' => { router=>&router_id, compiler=>&plain_copy },
    'imgs/*'   => { router=>&router_id, compiler=>&plain_copy },
    'static/*' => { router=>&ext2html,  compiler=>&compile_static },
    'posts/*'  => { router=>&ext2html,  compiler=>&compile_post },
    '_end'     => &do_end,
  );

my $pekyll = Pekyll.new(:rules(%rules));
$pekyll.build;

##

sub compile_post($src, $dst) {
  my $post = qq:x/Markdown.pl $src/;
  my $basename = IO::Path.new($src).basename.subst(/\.md$/, "");

  $post = $post.subst('%%BASE_URI%%', '../', :g);  # FIXME base_uri
  my $output = $t6.process('static', 
        :post(1),
        :basename($basename), :content($post), :base_uri('../')); # FIXME base_uri
  spurt $dst, $output;

  # FIXME post "parsing"
  my $raw = slurp $src;
  my @lines = $raw.lines;
  my ($when, $who) = split(', por ', @lines[3]);
  $when = $when.subst(/\s+/, "", :g);
  $who = $who.subst('<', '&lt;');
  $who = $who.subst('>', '&gt;');
  my $title = @lines[1].subst(/^\s*\#\s*/, "");
  my $order = $when.subst(/\D/, "", :g);
  my $clean = @lines[5].subst(/\<.*?\>/, "", :g);
  my @words = $clean.words;
  my $img = '';
  $post ~~ m/\<img.*?src\=(\'||\")(.*?)(\'||\")/ and $img = $1.Str;
  if $img {
    my @ll = $img.split('/');
    $img = join('/', ('imgs',@ll[*-1]));
  }
  else {
    $img = 'assets/noimage.jpg';
  }

  my %post = ( title=>$title, who=>$who, when=>$when, order=>$order, basename=>$basename, stub=>@words[0..20].join(" "), raw=>$raw, html=>$output, img=>$img );
  %posts{$basename} = %post;
}

sub compile_static($src, $dst) {
  my $content = qq:x/Markdown.pl $src/;
  my $output = $t6.process('static', :post(0), :content($content), :base_uri<../>);
  spurt $dst, $output;
}

sub do_end($dst) {
  my @sorted = %posts.keys.sort: { %posts{$^b}<order> <=> %posts{$^a}<order> };
  my @latest;
  my @items;
  my %archive;

  for @sorted -> $p {
    @latest.push(%posts{$p}) if (@latest.elems < 5);
    @items.push(Syndication::RSS::Item.new(:title(%posts{$p}<title>), :link("http://perl.pt/posts/%posts{$p}<basename>.html"), :summary(%posts{$p}<stub>), :author(%posts{$p}<who>), :updated(DateTime.now))) if (@items.elems < 10);   # feed items list size  FIXME item contents

    my ($y, $m, $d) = %posts{$p}<when>.split('-');
    %archive{ +($y) }{ +($m) }.push(%posts{$p});
  }

  # build feed
  my $feed = Syndication::RSS.new(:title<perl.pt>, :link<http://perl.pt>, :description<perl.pt>, :items(@items));  # TODO add items to feed
  spurt "$dst/rss.xml", $feed.XML.Str;

  # FIXME move this to a template when possible
  my $arch_html = '<ul>';
  for %archive.keys.sort.reverse -> $year {
    $arch_html ~= join('', ('<li>',$year));
    $arch_html ~= '<ul>';
    for %archive{$year}.keys.sort({ $^a <= $^b }) -> $month {
      if %archive{$year}{$month} {
        $arch_html ~= join('', ('<li>',$month,'<ul>'));

        my @list := %archive{$year}{$month};
        for @list -> $post {
 #         my $curr = $post.shift;  # FIXME
#          say $post.perl; say "---\n";
          $arch_html ~= join('', ('<li><a href="posts/',$post<basename>,'.html">',$post<title>,'</a></li>'));
        }
        $arch_html ~= '</ul></li>';
      }
    }
    $arch_html ~= '</ul>';
    $arch_html ~= '</li>';
  }
  $arch_html ~= '</ul>';
  my $output = $t6.process('arquivo', :arch_html($arch_html), :base_uri<./>);
  spurt "$dst/arquivo.html", $output;

  # build index
  # FIXME need counter for style
  for 0 .. (@latest.elems - 1) -> $i {
    @latest[$i]{'counter'} = $i;
  }
  $output = $t6.process('index', :latest(@latest), :base_uri<./>);
  spurt "$dst/index.html", $output;
}

