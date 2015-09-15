
# Perl 5 - Post-derreferencing

 2015-09-16, por Alberto Simões <ambs@cpan.org>

Hoje vou-vos apresentar uma outra funcionalidade experimental do Perl 5.
Ao contrário das assinaturas de funções, que já uso em bastantes programas,
esta ainda não me cativou suficientemente. Mas quem sabe alguns de vós queiram
passar a ser seus novos utilizadores.

A funcionalidade chama-se `postderef` e, tal como no caso das assinaturas, 
também esta funcionalidade tem de ser importada à força, e desligados os avisos:

    no warnings 'experimental::postderef';
    use feature 'postderef';

E que permite isto? Bem, se já andam fartos de fazer *castings*, como em

    for my $key (keys %{ $some{$var} }) {
        // ...
    }

podem passar a usar uma solução com menos chavetas:

    for my $key (keys $some{$var}->%* ) {
        // ...
    }

Não tenho a certeza de qual a mais elegante. Estou, sem dúvida, demasiado
habituado à primeira que, de qualquer modo, me recorda dos velhos *type casting*
do C. Mas a segunda torna o código um pouco mais legível...?:

<img src="/imgs/raptor.png" style="display: none"/>

