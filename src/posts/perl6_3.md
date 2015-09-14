
# Perl 6 - Histograma de Palavras

 2015-09-14, por Alberto Simões <ambs@cpan.org>

Um exercício simples e típico, quando aprendemos uma nova linguagem de
programação, é a escrita de um pequeno programa que, dado um ficheiro de
texto, calcula quantas vezes cada palavra ocorre.

E para variar, vamos processar os parâmetros do programa à moda do 
Perl 5, olhando para o  `@ARGV` que, em Perl 6, se chama `@*ARGS`. A razão
daquele asterisco será detalhada noutra entrada.

    use v6;
    
    my $filename = shift @*ARGS;

O passo seguinte é verificar se o nome do ficheiro foi, realmente, indicado e,
em caso afirmativo, verificar se este é, ou não, um ficheiro:

    if !$filename || $filename.IO !~~ :f {
        die "filename not specified or not existent."
    }

Para além da falta de parentesis a que nos começamos a habituar, a segunda parte
da comparação apresenta algumas novidades. O `~~` é o *smart match*, um operador
que, embora em estado experimental, já foi introduzido no Perl 5. A sua negação é,
então, `!~~`. Ou seja, estamos a verificar se `$filename.IO` faz *match* a um `:f`.
O método `IO` sobre o nome do ficheiro transforma-o num handler de ficheiro (com
esse nome). O `:f` é uma propriedade equialente ao `-f` do Perl 5. Se tentarmos ler
este código poderíamos dizer algo como *se o nome do ficheiro não estiver definido 
ou se o ficheiro não existir (e não for um ficheiro convencional), então o programa
deverá terminar.

    my $contents = slurp $filename;
    
    my %histogram;
    for $contents ~~ m:global/\w+/ -> $word {
        %histogram{$word.lc}++;
    }

Segue-se a leitura do ficheiro, como um todo, para uma variável. Declara-se então
a variável onde se armazenará o histograma.

O ciclo `for` inclui dois pormenores distintos. Em primeiro lugar a sintaxe do 
ciclo, que deixa de necessitar dos parentesis, e que troca a ordem da lista e da
variável iteradora. Antes da seta `->` devemos indicar a lista a ser percorrida,
e de seguida, a variável que irá tomar o valor de cada um dos elementos da lista.

Para calcular a lista de palavras usamos expressões regulares típicas. Tal como no 
Perl 5, `\w` corresponde a um caracter alfanumérico, e portanto estamos à procura de
todas as sequências de caracteres alfanuméricos. Por sua vez, o `m:global` tem duas
partes: o `m` é o operador de *matching*, tal como já existia em Perl 5; o `:global`
é um advérbio que indica que esse *match* deve ser global (tal como o `/s` do Perl 5). Então, `$contents ~~ m:global/\w+/` retorna uma lista de todas as palavras
encontradas.

Já o corpo do ciclo é o habitual, incrementando o número de ocorrências de cada
palavra (depois de a ter transformado em minúsculas, com o método `lc`).

Só nos falta apresentar o resultado do histograma, ordenando as palavras por
ocorrência, em ordem decrescente.

    for %histogram.keys.sort({ %histogram{$^b} <=> %histogram{$^a}}) -> $key {
        say "$key  ==>  %histogram{$key} occurrences";
    }

Ora, para todas as chaves da variável `%histogram` ordenámo-las. Como não queremos
ordenar as palavras por ordem alfabética, mas pelo número de ocorrências, temos
de, tal como em Perl 5, indicar uma função de ordenação. Em Perl 6 as variáveis
para a comparação são `$^a` e `$^b`, ao contrário das `$a` e `$b` do Perl 5. À
parte desse detalhe, a sintaxe deverá ser fácil de compreender.

Executando o script sobre o ficheiro onde este texto está escrito, obtemos um
resultado semelhante ao seguinte:

    ambs$ perl6 teste3.pl6 perl6_3.md
    o  ==>  25 occurrences
    a  ==>  23 occurrences
    de  ==>  21 occurrences
    do  ==>  12 occurrences
    perl  ==>  11 occurrences
    um  ==>  11 occurrences
    e  ==>  10 occurrences
    se  ==>  10 occurrences
    que  ==>  9 occurrences
    ficheiro  ==>  9 occurrences
    é  ==>  9 occurrences
    [...]

<img src="/imgs/camelia.png" style="display: none" alt="Camelia" title="Camelia"/>

