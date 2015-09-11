
# Perl 6 - A função MAIN

 2015-09-11, por Alberto Simões <ambs@cpan.org>

Com o Perl 6 a sair no Natal, e sim, desta vez no próximo
Natal, começa a ser interessante olhar para esta linguagem
que demorou 15 anos a ser preparada.

O Perl 6 segue muita da filosofia do Perl 5, permitindo,
por exemplo, que se possa escrever um programa sem uma 
única função (nem sequer a função dita `main` do C). No entanto, 
o Perl 6 permite que o façam, definindo uma função especial,
denominada `MAIN`. Além disso, e como o Perl 6 suporta assinaturas
nas funções (ou seja, que argumentos são recebidos, a sua ordem e
os seus tipos) e suporta multiplas assinaturas por funções (ou seja,
funções com o mesmo nome, mas que podem receber argumentos diferentes),
a função `MAIN` pode ser escrita descrevendo os argumentos de linha
de comando obrigatórios.

Como exemplo, considere-se o seguinte programa que, dado um inteiro na linha 
de comandos, imprime a sua respectiva tabuada.

    sub MAIN(Int $a) {
        if $a < 0 {
            say "Argument should be positive";
        }
        else {
            for (1..10) {
                printf "%2d x %2d = %2d\n", $a, $_, $a*$_;
            }
        }
    }

Deste bloco de código as diferenças notórias em relação
ao Perl 5 são a assinatura da função `MAIN`, indicando que deve
receber um único argumento inteiro, e a estrutura condicional não
necessitar de parentesis. É certo que se poderia escrever este
programa de outras formas, introduzindo novas funcionalidades do
Perl 6, mas vamos tentar apresentá-las aos poucos.

Em relação à sua execução, temos este comportamento:

    ambs$ perl6 teste1.pl6
    Usage:
      teste1.pl6 <a>
    ambs$ perl6 teste1.pl6 3
     3 x  1 =  3
     3 x  2 =  6
     3 x  3 =  9
     3 x  4 = 12
     3 x  5 = 15
     3 x  6 = 18
     3 x  7 = 21
     3 x  8 = 24
     3 x  9 = 27
     3 x 10 = 30
    ambs$ perl6 teste1.pl6 foo
    Usage:
      teste1.pl6 <a>


<img src="/imgs/camelia.png" alt="Camelia" title="Camelia"/>

