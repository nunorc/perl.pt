
# App::p5stack

 2015-10-05, por Nuno Carvalho <smash@cpan.org>

Gerir várias versões do Perl e/ou um repositório de módulos pode dar
origem a tarefas ou *workflows* complexos. Felizmente existem uma série
de ferramentas que podem auxiliar nestes processos, por exemplo:

  * [perlbrew](https://metacpan.org/release/App-perlbrew)
  * [cpanminus](https://metacpan.org/release/App-perlbre://metacpan.org/release/App-cpanminus)
  * [local::lib](https://metacpan.org/release/App-perlbre://metacpan.org/release/App-cpanminu://metacpan.org/release/local-lib)
  * [Carton](https://metacpan.org/release/Carton)
  * [Carmel](https://metacpan.org/release/Carto://metacpan.org/release/Carmel)

Utilizando uma (ou várias) combinações destas ferramentas é possível
usar vários versões de módulos/versões de Perl. No entanto é
preciso que o programador tenha conhecimento sobre estas ferramentas,
e por vezes uma série de instruções (ou lista de comandos) de como fazer
o *setup* necessário para correr uma aplicação podem interferir com
instalações de sistema ou gerais do utilizador. Outras vezes o programador
não quer investir tempo a aprender a usar este tipo de ferramentas para
efectuar simplesmente um teste (ou debug).

O objectivo do `p5stack` é de uma forma expedita e com uma curva de aprendizagem
mínima permitir *automagicamente* configurar um contexto para executar uma
aplicação localmente (ao nível da directoria).

### Exemplo de utilização

Um projecto muito simples:

    $ ls -A
    dist.ini  ex1

que contém um script `ex1`:

    $ cat ex1
    #!/usr/bin/perl
    
    use Acme::123;
    
    Acme::123->new->printnumbers;

que tem uma dependência (o módulo `Acme::123`), como descrito na simples
configuração do dzil:

    $ cat dist.ini 
    name = ex1
    
    [Prereqs]
    Acme::123 = 0

Portanto para executar esta *aplicação* é necessário um interpretador
de Perl, e a lista de módulo necessário. Podemos preparar a directoria
deste *projecto* com tudo que é necessário para correr a aplicação com
o p5stack, executado o comando `p5stack setup` na própria directoria:

    $ p5stack setup
    [p5stack - Sep 28 23:58:19] Hammering setup ...
    (...)

O `setup` chamado sem qualquer configuração vai utilizar o Perl de sistema
encontrado, e vai criar uma directoria `.local` que vai conter todos
os módulos necessários para executar a aplicação:

    $ ls -A
    .local  dist.ini  ex1

Sem fazer qualquer alteração aos módulos de sistema. Depois é possível
utilizar o p5stack para correr a aplicação usando o comando
`p5stack perl` que arranca o interpretador de Perl, com a configuração
necessária para este contexto:

    $ p5stack perl ex1 
    one 
    two 
    three 
    (...)

É possível definir um ficheiro de configuração para usar outras versões
de Perl, ou outras formas para inferir a lista de dependências. Por
exemplo o seguinte ficheiro de configuração:

    $ cat p5stack.yml
    ---
    perl: 5.20.3
    deps: cpanfile

na directoria do projecto ia fazer com que o setup instalasse um Perl
(da versão definida) na $HOME do utilizador, os módulos necessários iriam
ser na mesma instalados em `.local`, mas a diferença é que neste caso a
lista de dependências seria calculada com base no ficheiro `cpanfile`. O
importante é que tudo é feito sem interferir com outras instalações do
Perl (ou perbrew) e que os módulos são sempre locais ao projecto.

Mais informações sobre a ferramenta (ainda em 
desenvolvimento) na página do [projecto](https://github.com/nunorc/App-p5stack)
(*pull requests are welcome*).

