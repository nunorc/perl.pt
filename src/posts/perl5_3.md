
# Perl 5 - Substituição com retorno

 2015-09-17, por Alberto Simões <ambs@cpan.org>

Há muito que esperava algo deste género. Na verdade, diria mesmo que foi
um erro de concepção não ter surgido logo no início. De que falo? Do
modificador das substituições que permitem indicar que a substituição
deve ser feita numa cópia da string, e que deve ser essa cópia a ser
retornada ao comando anterior.

Para vos dar um exemplo:

    my $string = "Associação Portuguesa de Programadores Perl";
    my $other = $string =~ s/Perl/PHP/r;
    print "$string\n";
    print "$other\n";

O resultado é a impressão da *string original*, sem qualquer substituição,
seguida da *string alterada*.
Qual a principal vantagem? Bem, até agora o código anterior tinha de ser 
escrito como:

    my $string = "Associação Portuguesa de Programadores Perl";
    (my $other = $string) =~ s/Perl/PHP/;
    print "$string\n";
    print "$other\n";

Que não é a coisa mais legível. Ou então, a versão mais verbosa e mais legível:

    my $string = "Associação Portuguesa de Programadores Perl";
    my $other = $string;
    $other =~ s/Perl/PHP/;
    print "$string\n";
    print "$other\n";

Mas há outras situações em que esta nova opção da substituição pode ser muito 
útil. Primeiro exemplo, no uso de um *map*. Dada uma lista de palavras, substituir
todas as ocorrências de "ph" por "f" (suponham um conjunto de palavras em grafia
anterior a 1940, como "pharmácia"). Sem a substituição sem retorno, ter-se-ia de
fazer algo como:

    my @modern = map { s/ph/f/; $_ } @old;

Com a opção de substituição, podemos ser mais eficientes:

    my @modern = map { s/ph/f/r } @old;

Digam lá se não fica uma limpeza. A segunda situação em que gosto deste modificador
é a possibilidade de encadear substituições. Suponham a remoção de todos os 
espaços no início da linha ou no final da linha, e a substituição de sequências com
mais de um espaço por apenas um espaço. Claro que podem escrever:

    sub normalize {
       $_[0] =~ s/(^\s+|\s+$)//g;
       $_[0] =~ s/\s+/ /g;
       return $_[0];
    }

Não podemos dizer que não seja legível... mas podemos fazê-lo com:

    sub normalize {
        return $_[0] =~ s/(^\s+|\s+$)//gr =~ s/\s+/ /gr;
    }

Não fica lindo!?? 😊

<img src="/imgs/raptor.png" style="display: none"/>

