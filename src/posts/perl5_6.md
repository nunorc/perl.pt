
# Perl 5 - Time::ETA

 2015-09-28, por Alberto Simões <ambs@cpan.org>

Calcular o tempo previsto para uma tarefa é algo complicado. É
essa a principal razão de todos nós odiarmos as barras de progresso
e a forma desigual de como vão crescendo.

No entanto, se tivermos um processo que vai repetir *n* vezes um
bloco de código bastante estável em termos de tempo de processamento,
é possível prever o tempo total do processo, multiplicando esse *n*
pelo tempo de uma iteração do dito bloco de código. Há medida que
vamos executando várias iterações desse bloco, podemos ir calculando
um valor médio do tempo dispendido e, assim, obtendo uma previsão
mais real do tempo estimado.

É esta a tarefa do módulo `Time::ETA`. O seu funcionamento mínimal
é bastante simples. Começamos por criar um objeto e indicar o 
número de iterações que iremos executar:

     my $eta = Time::ETA->new(milestones => 12);

Posteriormente, a cada iteração sobre o bloco de código, indicamos
que atingimos uma *milestone*:

     $eta->pass_milestone();

Podemos também, a cada ciclo, ou em cada *m* ciclos, imprimir o estado
do processo:

     printf STDERR "%.2f%% [ETA %s]\r",
          $eta->get_completed_percent(),
          $eta->get_remaining_time();

E no final, podemos indicar o número de segundos decorridos:

     printf STDERR "Process completed in %d seconds\n",
          $eta->get_elapsed_seconds();

Infelizmente, *ainda* não existe um método que indique o tempo 
decorrido devidamente formatado. Mas espero que o autor adicione
em breve.


<img src="/imgs/raptor.png" style="display: none"/>

