
# Perl 6 - Leitura de ficheiros

 2015-09-12, por Alberto Simões <ambs@cpan.org>

Após a experiência de ontem, com o uso da função `MAIN`, podemos
dedicar-mo-nos a coisas um bocadinho mais complicadas. Tentando 
introduzir o mínimo de novas construções de cada vez, vamos escrever
um pequeno programa que, dado o nome de um ficheiro, imprime para o
`STDOUT` esse mesmo ficheiro com as linhas numeradas. Algo semelhante
ao que o comando unix `nl` faz.

Uma solução completa poderia ser:

    use v6;
     
    sub MAIN(Str $filename ) {
        my @file = (slurp $filename).lines;
        for (1..@file.elems) {
            printf "%5d: %s\n", $_, @file[$_-1];
        }
    }

Em primeiro lugar, começamos por usar a directiva a indicar que estamos 
perante o Perl 6. Não é imprescindível, como vimos no exemplo de ontem, 
mas é uma boa prática.

A definição da função `MAIN` já não é novidade. Neste caso usamos o tipo
`String`, já que esperamos que nos seja indicado o nome de um ficheiro.

O Perl 6 inclui no seu *core* a função `slurp`, que dado o nome de um ficheiro
o lê para uma string. Posteriormente, o método `lines` pode ser invocado sobre
essa string para obter uma lista de linhas (em que o separador de linha, ou 
seja, o *new line*, já foi removido).

De seguida temos um ciclo comum. Podemos verificar que, par calcular o número
de elementos de uma lista de usa o método `elems`. A impressão de cada linha, por 
si só, tem uma única novidade: o *sigil* de uma lista continua a ser o `@` mesmo
quando se acede a cada um dos elementos.

Segue-se o resultado de algumas invocações deste programa.

    ambs$ perl6 teste2.pl6
    Usage:
      teste2.pl6 <filename>
    ambs$ perl6 teste2.pl6 filename
    Failed to open file /Users/ambs/MyReps/perl.pt/mine/filename: no such file or directory
      in sub MAIN at teste2.pl6:4
      in block <unit> at teste2.pl6:3
    
    ambs$ perl6 teste2.pl6 teste2.pl6
        1: use v6;
        2:
        3: sub MAIN(Str $filename ) {
        4:  my @file = (slurp $filename).lines;
        5:  for (1..@file.elems) {
        6:      printf "%5d: %s\n", $_, @file[$_-1];
        7:  }
        8: }

<img src="/imgs/camelia.png" style="display: none" alt="Camelia" title="Camelia"/>

