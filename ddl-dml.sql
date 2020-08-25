BEGIN TRANSACTION;
DROP TABLE IF EXISTS "questao";
CREATE TABLE IF NOT EXISTS "questao" (
	"id_questao"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"enunciado"	TEXT NOT NULL,
	"alternativa_id"	INTEGER NOT NULL,
	FOREIGN KEY("alternativa_id") REFERENCES "alternativa"("id_alternativa")
);
DROP TABLE IF EXISTS "disciplina_avaliacao";
CREATE TABLE IF NOT EXISTS "disciplina_avaliacao" (
	"avaliacao_id"	INTEGER NOT NULL,
	"disciplina_id"	INTEGER NOT NULL,
	FOREIGN KEY("avaliacao_id") REFERENCES "avaliacao"("id_avaliacao"),
	FOREIGN KEY("disciplina_id") REFERENCES "disciplina"("id_disciplina")
);
DROP TABLE IF EXISTS "avaliacao";
CREATE TABLE IF NOT EXISTS "avaliacao" (
	"id_avaliacao"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"nome"	TEXT NOT NULL
);
DROP TABLE IF EXISTS "avaliacao_questao";
CREATE TABLE IF NOT EXISTS "avaliacao_questao" (
	"avaliacao_id"	INTEGER NOT NULL,
	"questao_id"	INTEGER NOT NULL,
	FOREIGN KEY("avaliacao_id") REFERENCES "avaliacao"("id_avaliacao"),
	FOREIGN KEY("questao_id") REFERENCES "questao"("id_questao")
);
DROP TABLE IF EXISTS "usuario_disciplina";
CREATE TABLE IF NOT EXISTS "usuario_disciplina" (
	"usuario_id"	INTEGER NOT NULL,
	"disciplina_id"	INTEGER NOT NULL,
	FOREIGN KEY("usuario_id") REFERENCES "usuario"("id_usuario"),
	FOREIGN KEY("disciplina_id") REFERENCES "disciplina"("id_disciplina")
);
DROP TABLE IF EXISTS "disciplina";
CREATE TABLE IF NOT EXISTS "disciplina" (
	"id_disciplina"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"nome"	TEXT NOT NULL
);
DROP TABLE IF EXISTS "usuario";
CREATE TABLE IF NOT EXISTS "usuario" (
	"id_usuario"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"nome"	TEXT NOT NULL,
	"email"	TEXT NOT NULL,
	"senha"	TEXT NOT NULL
);
DROP TABLE IF EXISTS "questao_alternativa";
CREATE TABLE IF NOT EXISTS "questao_alternativa" (
	"alternativa_id"	INTEGER NOT NULL,
	"questao_id"	INTEGER NOT NULL,
	FOREIGN KEY("alternativa_id") REFERENCES "alternativa"("id_alternativa"),
	FOREIGN KEY("questao_id") REFERENCES "questao"("id_questao")
);
DROP TABLE IF EXISTS "alternativa";
CREATE TABLE IF NOT EXISTS "alternativa" (
	"id_alternativa"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"alternativa"	TEXT NOT NULL
);
DROP TABLE IF EXISTS "resposta";
CREATE TABLE IF NOT EXISTS "resposta" (
	"count"	INTEGER,
	"usuario_id"	INTEGER NOT NULL,
	"avaliacao_id"	INTEGER NOT NULL,
	"disciplina_id"	INTEGER NOT NULL,
	"id_resposta"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	FOREIGN KEY("disciplina_id") REFERENCES "disciplina"("id_disciplina"),
	FOREIGN KEY("usuario_id") REFERENCES "usuario"("id_usuario"),
	FOREIGN KEY("avaliacao_id") REFERENCES "avaliacao"("id_avaliacao")
);
INSERT INTO "questao" VALUES (1,'Sobre a primeira forma normal (1FN), examine as assertivas abaixo.<br>I - Uma tabela na 1FN pode conter tabelas aninhadas.<br>II - Uma tabela na 1FN pode possuir apenas atributos atômicos e monovalorados.<br>III - Uma tabela na 1FN pode possuir apenas uma chave primária do tipo simples (não composta).<br>Está (Estão) correta(s) a(s) assertiva(s)',2);
INSERT INTO "questao" VALUES (2,' De acordo com a normalização de entidades em bancos de dados relacionais, a entidade cujos atributos não chave independem de outro atributo não chave está na ',9);
INSERT INTO "questao" VALUES (3,'Normalização de dados é um processo que visa eliminar dados redundantes e garantir que a dependência de dados faça sentido. O processo de normalização gera tabelas que se apresentam normalmente em 1FN (primeira forma normal), 2FN (segunda forma normal) e 3FN (terceira forma normal). Assinale a alternativa que indica especificamente a(s) forma(s) normal(is) que aplica a regra “não possuir atributos com dependência transitiva dependentes da chave”:',11);
INSERT INTO "questao" VALUES (4,'Em POO, duas ou mais classes, derivadas de uma mesma superclasse, podem invocar métodos que têm a mesma identificação (assinatura), mas comportamentos distintos, especializados para cada classe derivada, usando para tanto uma referência a um objeto do tipo dessa superclasse.<br>O texto acima diz respeito a ',20);
INSERT INTO "questao" VALUES (5,'Assinale a alternativa correta, considerando o paradigma da orientação a objeto, para as afirmações abaixo:<br>Carlos pode andar, correr, pular. Ele tem 25 anos, é casado e trabalha com Tecnologia da Informação e Comunicação então: ',21);
INSERT INTO "questao" VALUES (6,' Qual das alternativas a seguir define corretamente o Encapsulamento na programação orientada a objetos? ',29);
INSERT INTO "questao" VALUES (7,'Durante o desenvolvimento de uma aplicação orientada a objetos com Java, um Técnico criou uma interface para obrigar um conjunto de classes de diferentes origens a implementar certos métodos de maneiras diferentes, viabilizando a obtenção de polimorfismo. A interface criada pelo Técnico pode ',33);
INSERT INTO "questao" VALUES (8,'O Object Pascal é uma linguagem de programação com suporte a orientação a objetos. Sobre as ferramentas utilizadas para programar em Object Pascal, assinale a alternativa correta.',36);
INSERT INTO "questao" VALUES (9,'A POO é um modelo de análise, projeto e programação de software baseado na composição e interação entre diversas unidades chamadas de objetos. Assinale a alternativa que apresenta os itens considerados os quatro pilares da POO.',42);
INSERT INTO "questao" VALUES (10,'Em sistemas distribuídos, clusterização é o nome que se dá ao processo de interconexão de múltiplas máquinas com o objetivo de obter um aumento de disponibilidade, desempenho ou capacidade total de um sistema. Em relação à clusterização é correto afirmar:',44);
INSERT INTO "questao" VALUES (11,'Computadores de baixo custo podem ser agrupados em clusters, onde exercem funções que exigem alto desempenho computacional como se fossem uma única máquina de grande porte. É correto afirmar que um cluster Beowulf com o sistema operacional Linux é constituído de vários nós escravos,',48);
INSERT INTO "questao" VALUES (12,'O multiprocessamento simétrico pode ser implementado, por meio de clusters de servidores, usando-se o método secundário ativo, no qual um servidor secundário assume o processamento em caso de falha do servidor primário. Assinale a opção que apresenta corretamente uma justificativa para o uso do método secundário ativo.',50);
INSERT INTO "questao" VALUES (13,'Assinale a opção que contém uma regra INVÁLIDA para Redes de Petri',53);
INSERT INTO "questao" VALUES (14,'Sobre o processamento paralelo e distribuído, assinale a afirmação correta.',55);
INSERT INTO "questao" VALUES (15,'Um sistema distribuído é definido como uma coleção de computadores independentes que se apresenta ao usuário como um sistema único e consistente. Baseado nos conceitos definidos para sistemas distribuídos, identifique a afirmativa ERRADA:',60);
INSERT INTO "disciplina_avaliacao" VALUES (1,2);
INSERT INTO "disciplina_avaliacao" VALUES (2,2);
INSERT INTO "disciplina_avaliacao" VALUES (3,1);
INSERT INTO "disciplina_avaliacao" VALUES (4,3);
INSERT INTO "disciplina_avaliacao" VALUES (5,3);
INSERT INTO "avaliacao" VALUES (1,'Avaliação - POO');
INSERT INTO "avaliacao" VALUES (2,'Recuperação - POO');
INSERT INTO "avaliacao" VALUES (3,'Avaliação - BCD');
INSERT INTO "avaliacao" VALUES (4,'Avaliação - STD');
INSERT INTO "avaliacao" VALUES (5,'Recuperação - STD');
INSERT INTO "avaliacao_questao" VALUES (3,1);
INSERT INTO "avaliacao_questao" VALUES (3,2);
INSERT INTO "avaliacao_questao" VALUES (3,3);
INSERT INTO "avaliacao_questao" VALUES (1,4);
INSERT INTO "avaliacao_questao" VALUES (1,5);
INSERT INTO "avaliacao_questao" VALUES (1,6);
INSERT INTO "avaliacao_questao" VALUES (2,7);
INSERT INTO "avaliacao_questao" VALUES (2,8);
INSERT INTO "avaliacao_questao" VALUES (2,9);
INSERT INTO "avaliacao_questao" VALUES (4,10);
INSERT INTO "avaliacao_questao" VALUES (4,11);
INSERT INTO "avaliacao_questao" VALUES (4,12);
INSERT INTO "avaliacao_questao" VALUES (5,13);
INSERT INTO "avaliacao_questao" VALUES (5,14);
INSERT INTO "avaliacao_questao" VALUES (5,15);
INSERT INTO "usuario_disciplina" VALUES (1,1);
INSERT INTO "usuario_disciplina" VALUES (1,2);
INSERT INTO "usuario_disciplina" VALUES (2,2);
INSERT INTO "usuario_disciplina" VALUES (2,3);
INSERT INTO "usuario_disciplina" VALUES (3,1);
INSERT INTO "disciplina" VALUES (1,'BCD29008');
INSERT INTO "disciplina" VALUES (2,'POO29004');
INSERT INTO "disciplina" VALUES (3,'STD29006');
INSERT INTO "usuario" VALUES (1,'Juca','aluno1@email','1234');
INSERT INTO "usuario" VALUES (2,'Luiza','aluno2@email','12345');
INSERT INTO "usuario" VALUES (3,'Rose','aluno3@email','123456');
INSERT INTO "questao_alternativa" VALUES (1,1);
INSERT INTO "questao_alternativa" VALUES (2,1);
INSERT INTO "questao_alternativa" VALUES (3,1);
INSERT INTO "questao_alternativa" VALUES (4,1);
INSERT INTO "questao_alternativa" VALUES (5,1);
INSERT INTO "questao_alternativa" VALUES (6,2);
INSERT INTO "questao_alternativa" VALUES (7,2);
INSERT INTO "questao_alternativa" VALUES (8,2);
INSERT INTO "questao_alternativa" VALUES (9,2);
INSERT INTO "questao_alternativa" VALUES (10,2);
INSERT INTO "questao_alternativa" VALUES (11,3);
INSERT INTO "questao_alternativa" VALUES (12,3);
INSERT INTO "questao_alternativa" VALUES (13,3);
INSERT INTO "questao_alternativa" VALUES (14,3);
INSERT INTO "questao_alternativa" VALUES (15,3);
INSERT INTO "questao_alternativa" VALUES (16,4);
INSERT INTO "questao_alternativa" VALUES (17,4);
INSERT INTO "questao_alternativa" VALUES (18,4);
INSERT INTO "questao_alternativa" VALUES (19,4);
INSERT INTO "questao_alternativa" VALUES (20,4);
INSERT INTO "questao_alternativa" VALUES (21,5);
INSERT INTO "questao_alternativa" VALUES (22,5);
INSERT INTO "questao_alternativa" VALUES (23,5);
INSERT INTO "questao_alternativa" VALUES (24,5);
INSERT INTO "questao_alternativa" VALUES (25,5);
INSERT INTO "questao_alternativa" VALUES (61,6);
INSERT INTO "questao_alternativa" VALUES (26,6);
INSERT INTO "questao_alternativa" VALUES (27,6);
INSERT INTO "questao_alternativa" VALUES (28,6);
INSERT INTO "questao_alternativa" VALUES (29,6);
INSERT INTO "questao_alternativa" VALUES (30,7);
INSERT INTO "questao_alternativa" VALUES (31,7);
INSERT INTO "questao_alternativa" VALUES (32,7);
INSERT INTO "questao_alternativa" VALUES (33,7);
INSERT INTO "questao_alternativa" VALUES (34,7);
INSERT INTO "questao_alternativa" VALUES (62,8);
INSERT INTO "questao_alternativa" VALUES (35,8);
INSERT INTO "questao_alternativa" VALUES (36,8);
INSERT INTO "questao_alternativa" VALUES (37,8);
INSERT INTO "questao_alternativa" VALUES (38,8);
INSERT INTO "questao_alternativa" VALUES (63,9);
INSERT INTO "questao_alternativa" VALUES (39,9);
INSERT INTO "questao_alternativa" VALUES (40,9);
INSERT INTO "questao_alternativa" VALUES (41,9);
INSERT INTO "questao_alternativa" VALUES (42,9);
INSERT INTO "questao_alternativa" VALUES (65,10);
INSERT INTO "questao_alternativa" VALUES (64,10);
INSERT INTO "questao_alternativa" VALUES (43,10);
INSERT INTO "questao_alternativa" VALUES (44,10);
INSERT INTO "questao_alternativa" VALUES (45,10);
INSERT INTO "questao_alternativa" VALUES (66,11);
INSERT INTO "questao_alternativa" VALUES (67,11);
INSERT INTO "questao_alternativa" VALUES (46,11);
INSERT INTO "questao_alternativa" VALUES (47,11);
INSERT INTO "questao_alternativa" VALUES (48,11);
INSERT INTO "questao_alternativa" VALUES (68,12);
INSERT INTO "questao_alternativa" VALUES (69,12);
INSERT INTO "questao_alternativa" VALUES (49,12);
INSERT INTO "questao_alternativa" VALUES (50,12);
INSERT INTO "questao_alternativa" VALUES (51,12);
INSERT INTO "questao_alternativa" VALUES (71,13);
INSERT INTO "questao_alternativa" VALUES (70,13);
INSERT INTO "questao_alternativa" VALUES (52,13);
INSERT INTO "questao_alternativa" VALUES (53,13);
INSERT INTO "questao_alternativa" VALUES (54,13);
INSERT INTO "questao_alternativa" VALUES (72,14);
INSERT INTO "questao_alternativa" VALUES (73,14);
INSERT INTO "questao_alternativa" VALUES (55,14);
INSERT INTO "questao_alternativa" VALUES (56,14);
INSERT INTO "questao_alternativa" VALUES (57,14);
INSERT INTO "questao_alternativa" VALUES (74,15);
INSERT INTO "questao_alternativa" VALUES (75,15);
INSERT INTO "questao_alternativa" VALUES (58,15);
INSERT INTO "questao_alternativa" VALUES (59,15);
INSERT INTO "questao_alternativa" VALUES (60,15);
INSERT INTO "alternativa" VALUES (1,'Apenas I. ');
INSERT INTO "alternativa" VALUES (2,'Apenas II. ');
INSERT INTO "alternativa" VALUES (3,'Apenas III. ');
INSERT INTO "alternativa" VALUES (4,'Apenas I e II.');
INSERT INTO "alternativa" VALUES (5,'Apenas II e III. ');
INSERT INTO "alternativa" VALUES (6,'quinta forma normal (5FN).');
INSERT INTO "alternativa" VALUES (7,'primeira forma normal (1FN).');
INSERT INTO "alternativa" VALUES (8,'segunda forma normal (2FN).');
INSERT INTO "alternativa" VALUES (9,'terceira forma normal (3FN).');
INSERT INTO "alternativa" VALUES (10,'quarta forma normal (4FN).');
INSERT INTO "alternativa" VALUES (11,'3FN');
INSERT INTO "alternativa" VALUES (12,'2FN');
INSERT INTO "alternativa" VALUES (13,'1FN');
INSERT INTO "alternativa" VALUES (14,'1FN e 2FN');
INSERT INTO "alternativa" VALUES (15,'2FN e 3FN');
INSERT INTO "alternativa" VALUES (16,'abstração. ');
INSERT INTO "alternativa" VALUES (17,'acoplamento.');
INSERT INTO "alternativa" VALUES (18,'encapsulamento.');
INSERT INTO "alternativa" VALUES (19,'herança. ');
INSERT INTO "alternativa" VALUES (20,'polimorfismo. ');
INSERT INTO "alternativa" VALUES (21,'Carlos é um objeto. Tem como métodos andar, correr e pular e, ter 25 anos, ser casado e trabalhar com TICs são variáveis ou estados. ');
INSERT INTO "alternativa" VALUES (22,'Andar, correr e pular, são objetos que podem ter como variável Carlos. ');
INSERT INTO "alternativa" VALUES (23,'Carlos é uma classe pois há outros Carlos que têm idade diferente de 25 anos e que exercem outras profissões. ');
INSERT INTO "alternativa" VALUES (24,'Ter 25 anos, ser casado, andar e correr são estados que podem ser associados ao objeto Carlos. ');
INSERT INTO "alternativa" VALUES (25,'Define habilidades e comportamentos de um objeto.');
INSERT INTO "alternativa" VALUES (26,'É uma chamada a um objeto para invocar um de seus métodos, ativando um comportamento descrito por sua classe.');
INSERT INTO "alternativa" VALUES (27,'É a habilidade de concentrar nos aspectos essenciais de um contexto qualquer, ignorando características menos importantes ou acidentais.');
INSERT INTO "alternativa" VALUES (28,'É um mecanismo onde uma classe pode estender uma outra classe, aproveitando seus métodos e atributos.');
INSERT INTO "alternativa" VALUES (29,'Este mecanismo é utilizado para impedir o acesso direto aos atributos de um objeto, disponibilizando externamente apenas os métodos que alteram estes atributos.');
INSERT INTO "alternativa" VALUES (30,'conter métodos implementados.');
INSERT INTO "alternativa" VALUES (31,'ser instanciada diretamente.');
INSERT INTO "alternativa" VALUES (32,' possuir um único construtor vazio.');
INSERT INTO "alternativa" VALUES (33,'possuir métodos abstratos.');
INSERT INTO "alternativa" VALUES (34,'conter variáveis e métodos privados.');
INSERT INTO "alternativa" VALUES (35,'Enterprise Business Solutions');
INSERT INTO "alternativa" VALUES (36,'Embarcadero Delphi');
INSERT INTO "alternativa" VALUES (37,'Eclipises');
INSERT INTO "alternativa" VALUES (38,'Komodu');
INSERT INTO "alternativa" VALUES (39,'Abstração - Encapsulamento - Concretização - Modelagem');
INSERT INTO "alternativa" VALUES (40,'Estruturação - Modulorização - Concretização - Modelagem');
INSERT INTO "alternativa" VALUES (41,'Estruturação - Modulorização - Herança - Polimorfismo');
INSERT INTO "alternativa" VALUES (42,'Abstração - Encapsulamento - Herança - Polimorfismo');
INSERT INTO "alternativa" VALUES (43,'Failback é o processo no qual uma máquina assume os serviços de outra quando esta apresenta alguma falha.');
INSERT INTO "alternativa" VALUES (44,'Dependendo da natureza do serviço, executar uma operação de failover significa interromper as transações em andamento, perdendo-as, sendo necessário reiniciá-las após o término do processo');
INSERT INTO "alternativa" VALUES (45,'A principal diferença entre clusters assimétricos e simétricos é que no cluster simétrico há a figura de um servidor inativo aguardando uma falha de outro.');
INSERT INTO "alternativa" VALUES (46,'sendo que cada nó exerce o controle sobre seu nó vizinho e o último nó exercerá o controle sobre o primeiro nó.');
INSERT INTO "alternativa" VALUES (47,'sendo que cada nó exerce seu próprio controle.');
INSERT INTO "alternativa" VALUES (48,'controlados por um computador principal.');
INSERT INTO "alternativa" VALUES (49,'Caso seja definido que cada servidor utilizará apenas os seus próprios discos, os dados não precisam ser copiados entre os sistemas.');
INSERT INTO "alternativa" VALUES (50,'O servidor secundário também pode ser usado para o processamento de outras operações no sistema, além da função de assumir o processamento no caso de falha do servidor primário.');
INSERT INTO "alternativa" VALUES (51,'Mesmo quando cada servidor usa apenas os seus próprios discos, o método secundário ativo não exige o gerenciamento do equilíbrio, entre os servidores, das requisições vindas dos clientes.');
INSERT INTO "alternativa" VALUES (52,'Um caminho deve iniciar e terminar por um lugar.');
INSERT INTO "alternativa" VALUES (53,'Uma transição dispara quando alguma de suas entradas possui uma marcação (token).');
INSERT INTO "alternativa" VALUES (54,'Quando uma transição dispara, ela consome uma marcação (token) de cada uma das suas entradas e gera uma para cada saída.');
INSERT INTO "alternativa" VALUES (55,'A computação paralela é caracterizada pelo uso de vários processadores para executar uma computação de forma mais rápida, baseando-se no fato de que o processo de resolução de um problema pode ser dividido em tarefas menores, que podem ser realizadas simultaneamente através de algum tipo de coordenação.');
INSERT INTO "alternativa" VALUES (56,'A execução de tarefas em um ambiente de processadores distribuídos com acoplamento fraco prevê que a memória seja compartilhada entre os processos trabalhadores.');
INSERT INTO "alternativa" VALUES (57,'Em programação paralela não é necessário se conhecer a arquitetura de comunicação entre processadores para elaborar os programas.');
INSERT INTO "alternativa" VALUES (58,'Um sistema distribuído fracamente acoplado permite que máquinas e usuários do ambiente sejam fundamentalmente independentes, bem como a interação de forma limitada, quando isto for necessário, compartilhando recursos como discos e impressoras, entre outros.');
INSERT INTO "alternativa" VALUES (59,'O modelo de computação distribuída Peer-to-Peer é uma tecnologia que estabelece uma espécie de rede virtual de computadores, onde cada estação tem capacidades e responsabilidades equivalentes.');
INSERT INTO "alternativa" VALUES (60,'Uma vantagem dos sistemas distribuídos sobre os sistemas centralizados é a disponibilidade de software para este tipo de ambiente.');
INSERT INTO "alternativa" VALUES (61,'Este mecanismo é utilizado para facilitar o acesso direto aos atributos de um objeto.');
INSERT INTO "alternativa" VALUES (62,'Embarcados Delfium');
INSERT INTO "alternativa" VALUES (63,'Herança - Abstração  - Polimorfismo');
INSERT INTO "alternativa" VALUES (64,'Dependendo da natureza do serviço, executar uma operação é impossível.');
INSERT INTO "alternativa" VALUES (65,'Não há diferenças entre clusters assimétricos e simétricos.');
INSERT INTO "alternativa" VALUES (66,'sendo que cada nó precisa um do outro.');
INSERT INTO "alternativa" VALUES (67,'controlados por um computador principal chamado coxinha.');
INSERT INTO "alternativa" VALUES (68,'O servidor secundário nunca poderá ser usado para outros processos.');
INSERT INTO "alternativa" VALUES (69,'Cada servidor vários disquinhos.');
INSERT INTO "alternativa" VALUES (70,'Uma transição nunca dispara porque não tem nada.');
INSERT INTO "alternativa" VALUES (71,'Quando uma transição dispara, ela é excluída.');
INSERT INTO "alternativa" VALUES (72,'A computação paralela é caracterizada através de algum tipo de coordenação.');
INSERT INTO "alternativa" VALUES (73,'A execução de tarefas em um ambiente deve-se graças aos processos trabalhadores.');
INSERT INTO "alternativa" VALUES (74,'Um sistema distribuído fracamente acoplado permite que nada aconteça.');
INSERT INTO "alternativa" VALUES (75,'O modelo de computação distribuída Peer-to-Peer é muito diferente de uma rede overlay.');
INSERT INTO "resposta" VALUES (2,1,3,1,1);
COMMIT;
