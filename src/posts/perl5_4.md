
# Perl 5 - Try

 2015-09-20, por Alberto Simões <ambs@cpan.org>

Embora à primeira vista possa parecer que o Perl não
tem controlo de fluxo de excepções, a verdade é que tem.
É quase como que dizer que o Perl não tem sistema de
objetos nativo, quando sabemos que tem. Pode não ser o
que se espera de um desses sistemas, mas a verdade é que
o suporta.

Tal como no caso do suporte à programação orientada aos
objetos foram surgindo módulos para aumentar a expressividade
da linguagem e aumentar a funcionalidade do dito sistema
de objetos, como o Moo, Moose ou Mouse, também em relação
às excepções têm surgido alguns módulos que tornam a
gestão de excepções mais natural para quem já programou
uma linguagem como Java ou C#.

Existem dois módulos, o `Try` e o `Try::Tiny` e ambos
suportam quase a mesma coisa: um bloco `try` com um
bloco `catch` opcional.

A principal diferença é que o módulo `Try` precisa de um
Perl menos antigo (5.12 em diante), o que torna a sua 
sintaxe menos propensa a erros. A principal diferença
reside do `;` obrigatório, após o último bloco de código,
no caso do `Try::Tiny`.

Assim, o que em `Try::Tiny` se escreve:

    try {
        // exception code
    } catch {
        // exception handling
    };

Com o `Try` é possível escrever apenas

    try {
        // exception code
    } catch {
        // exception handling
    }

Não vou, neste texto, explicar o que são sistemas de excepções
e o significado desta sintaxe, que espero que já seja familiar
de uma outra qualquer linguagem de programação.

Só vou chamar à atenção que para *levantar* ou *atirar* uma 
excepção (tradução possível para *throw exception*) se usa o
comando `die`, seguido da mensagem de erro. No bloco `catch`
o módulo terá o cuidado de pegar na mensagem de erro, que em
princípio estará em `$@` e colocá-la num sítio mais comum: `$_`.

E com isto já não têm desculpa para não tratarem 
convenientemente as excepções dos diferentes módulos que usam.

<img src="/imgs/raptor.png" style="display: none"/>

