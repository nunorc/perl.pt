
# Perl 5 - Data::Dump

 2015-09-26, por Alberto Simões <ambs@cpan.org>

Um módulo que todos usamos para *debug*, mais cedo ou mais tarde, é o
`Data::Dumper`. Este módulo tem um conjunto de funcionalidades
interessantes.  Para além de ser um módulo disponível de raíz na
distribuição do Perl (um módulo do *core*), também permite que uma
estrutura de dados serializada através dele possa ser facilmente
interpretado pelo Perl com o comando `do`.

Mas existem vários outros módulos que permitem mostrar um objeto Perl,
com outras vantagens. Um desses módulos é o `Data::Dump`. O objetivo do
`Data::Dump` não é a serialização, propriamente dita, mas o *debug* por
humanos.

Veja-se um conjunto de exemplos:

    use Data::Dump;

    # 1 - Escalar
    dd "cavalo";

    # 2 - Array
    dd qw(cavalo esquilo rato);

    # 3 - referência
    dd [qw(cavalo esquilo rato)];

Temos como resultado:

    "cavalo"
    ("cavalo", "esquilo", "rato")
    ["cavalo", "esquilo", "rato"]

Ora, esta é já, sem dúvida, uma grande vantagem. Não se têm de preocupar qual o tipo
da variável que usam. Quantas vezes não usamos o `Data::Dumper` e obtemos uma lista
de variáveis `$VAR1`, `$VAR2`, etc.

Ora vejamos uma estrutura mais complexa:

    my $struct = { foo => [ 1 .. 50 ],
                   bar => [ { a => 'b', c => 'd' }]};
    
Temos como resultado, para o `Data::Dumper`:

    $VAR1 = {
          'foo' => [
                     1,
                     2,
               # ...
                     49,
                     50
                   ],
          'bar' => [
                     {
                       'c' => 'd',
                       'a' => 'b'
                     }
                   ]
        };

E para o nosso novo amigo, `Data::Dump`:

    { bar => [{ a => "b", c => "d" }], foo => [1 .. 50] }


Palavras, para quê?

<img src="/imgs/raptor.png" style="display: none"/>

