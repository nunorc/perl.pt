
# Perl 5 - Assinaturas de Funções

 2015-09-12, por Alberto Simões <ambs@cpan.org>

Embora o Perl 6 esteja previsto para breve, não nos podemos esquecer do
Perl 5 que, como dizia *Curtis "Ovid" Poe*, é *battle-tested*. Ou seja, 
é um software estável, com alterações ponderadas, e com retrocompatibilidade.

No entanto, o Perl 5 não tem deixado de evoluir. É certo que a versão 
principal continua no 5, mas a *minor versions* continuam a subir, e já
estamos na versão 5.22.0!

As versões recentes têm introduzido novas funcionalidades, habitualmente
designadas de *features*. Estas, enquanto estão em modo de teste, têm de
ser solicitadas ao interpretador do Perl para poderem ser usadas. Espera-se
que após várias versões sem alterações de semântica e de sintaxe dessas
mesmas funcionalidades, estas passem a estáveis, e disponíveis por omissão.

A funcionalidade de que vos quero falar surgiu com o Perl 5.20, adicionando
a possibilidade de definirmos assinaturas de funções. Ou seja, em vez de
usarmos as já habituais linhas de código:

     sub funcao {
         my ($arg1, $arg2, @args) = @_;
         // ...
     }

Podemos passar a usar algo muito mais prático e legível:

     sub funcao($arg1, $arg2, @args) {
        // ...
     }

É nesta altura que começam a dizer que o C tem isto há anos. É verdade, sim. Mas
como tão bem os portugueses costumam dizer, mais vale tarde do que nunca!!

Existem muitos outros detalhes que este tipo de assinatura permite, como
o uso de argumentos com valores por omissão. Mas deixemos esses detalhes
para outras alturas.

Falta só dizer que, para poderem usar as assinaturas de funções têm de importar
essa funcionalidade:

    use feature 'signatures';

Infelizmente o Perl irá queixar-se com um aviso, de que esta funcionalidade é
experimental. Se quiserem, podem calar o Perl adicionando esta linha (antes da
anterior):

    no warnings 'experimental::signatures';

<img src="/imgs/raptor.png" style="display: none"/>

