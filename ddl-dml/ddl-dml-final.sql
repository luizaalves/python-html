BEGIN TRANSACTION;
DROP TABLE IF EXISTS "avaliacao";
CREATE TABLE IF NOT EXISTS "avaliacao" (
	"id_avaliacao"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"nome"	TEXT NOT NULL,
	"feito"	BLOB DEFAULT 0
);
DROP TABLE IF EXISTS "questao";
CREATE TABLE IF NOT EXISTS "questao" (
	"id_questao"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"enunciado"	TEXT NOT NULL,
	"alternativa_id"	INTEGER NOT NULL,
	"resposta_usuario"	INTEGER,
	FOREIGN KEY("alternativa_id") REFERENCES "alternativa"("id_alternativa"),
	FOREIGN KEY("resposta_usuario") REFERENCES "alternativa"("id_alternativa")
);
DROP TABLE IF EXISTS "avaliacao_questao";
CREATE TABLE IF NOT EXISTS "avaliacao_questao" (
	"avaliacao_id"	INTEGER NOT NULL,
	"questao_id"	INTEGER NOT NULL,
	FOREIGN KEY("avaliacao_id") REFERENCES "avaliacao"("id_avaliacao"),
	FOREIGN KEY("questao_id") REFERENCES "questao"("id_questao")
);
DROP TABLE IF EXISTS "disciplina_avaliacao";
CREATE TABLE IF NOT EXISTS "disciplina_avaliacao" (
	"avaliacao_id"	INTEGER NOT NULL,
	"disciplina_id"	INTEGER NOT NULL,
	FOREIGN KEY("avaliacao_id") REFERENCES "avaliacao"("id_avaliacao"),
	FOREIGN KEY("disciplina_id") REFERENCES "disciplina"("id_disciplina")
);
DROP TABLE IF EXISTS "usuario_disciplina";
CREATE TABLE IF NOT EXISTS "usuario_disciplina" (
	"usuario_id"	INTEGER NOT NULL,
	"disciplina_id"	INTEGER NOT NULL,
	FOREIGN KEY("usuario_id") REFERENCES "usuario"("id_usuario"),
	FOREIGN KEY("disciplina_id") REFERENCES "disciplina"("id_disciplina")
);
DROP TABLE IF EXISTS "alternativa";
CREATE TABLE IF NOT EXISTS "alternativa" (
	"id_alternativa"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"alternativa"	TEXT NOT NULL,
	"questao_id"	INTEGER NOT NULL,
	FOREIGN KEY("questao_id") REFERENCES "questao"("id_questao")
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
INSERT INTO "avaliacao" VALUES (1,'Avaliação - POO',NULL);
INSERT INTO "avaliacao" VALUES (2,'Recuperação - POO',NULL);
INSERT INTO "avaliacao" VALUES (3,'Avaliação - BCD',NULL);
INSERT INTO "avaliacao" VALUES (4,'Avaliação - STD',NULL);
INSERT INTO "avaliacao" VALUES (5,'Recuperação - STD',NULL);
INSERT INTO "questao" VALUES (1,'Sobre a primeira forma normal (1FN), examine as assertivas abaixo.\n\nI - Uma tabela na 1FN pode conter tabelas aninhadas.\n\nII - Uma tabela na 1FN pode possuir apenas atributos atômicos e monovalorados.\n\nIII - Uma tabela na 1FN pode possuir apenas uma chave primária do tipo simples (não composta).\n\nEstá (Estão) correta(s) a(s) assertiva(s)',2,NULL);
INSERT INTO "questao" VALUES (2,' De acordo com a normalização de entidades em bancos de dados relacionais, a entidade cujos atributos não chave independem de outro atributo não chave está na ',9,NULL);
INSERT INTO "questao" VALUES (3,'Normalização de dados é um processo que visa eliminar dados redundantes e garantir que a dependência de dados faça sentido. O processo de normalização gera tabelas que se apresentam normalmente em 1FN (primeira forma normal), 2FN (segunda forma normal) e 3FN (terceira forma normal). Assinale a alternativa que indica especificamente a(s) forma(s) normal(is) que aplica a regra “não possuir atributos com dependência transitiva dependentes da chave”:',11,NULL);
INSERT INTO "questao" VALUES (4,'Em POO, duas ou mais classes, derivadas de uma mesma superclasse, podem invocar métodos que têm a mesma identificação (assinatura), mas comportamentos distintos, especializados para cada classe derivada, usando para tanto uma referência a um objeto do tipo dessa superclasse.\nO texto acima diz respeito a ',20,NULL);
INSERT INTO "questao" VALUES (5,'Assinale a alternativa correta, considerando o paradigma da orientação a objeto, para as afirmações abaixo:\nCarlos pode andar, correr, pular. Ele tem 25 anos, é casado e trabalha com Tecnologia da Informação e Comunicação então: ',21,NULL);
INSERT INTO "questao" VALUES (6,' Qual das alternativas a seguir define corretamente o Encapsulamento na programação orientada a objetos? ',29,NULL);
INSERT INTO "questao" VALUES (7,'Durante o desenvolvimento de uma aplicação orientada a objetos com Java, um Técnico criou uma interface para obrigar um conjunto de classes de diferentes origens a implementar certos métodos de maneiras diferentes, viabilizando a obtenção de polimorfismo. A interface criada pelo Técnico pode ',33,NULL);
INSERT INTO "questao" VALUES (8,'O Object Pascal é uma linguagem de programação com suporte a orientação a objetos. Sobre as ferramentas utilizadas para programar em Object Pascal, assinale a alternativa correta.',36,NULL);
INSERT INTO "questao" VALUES (9,'A POO é um modelo de análise, projeto e programação de software baseado na composição e interação entre diversas unidades chamadas de objetos. Assinale a alternativa que apresenta os itens considerados os quatro pilares da POO.',42,NULL);
INSERT INTO "questao" VALUES (10,'Em sistemas distribuídos, clusterização é o nome que se dá ao processo de interconexão de múltiplas máquinas com o objetivo de obter um aumento de disponibilidade, desempenho ou capacidade total de um sistema. Em relação à clusterização é correto afirmar:',44,NULL);
INSERT INTO "questao" VALUES (11,'Computadores de baixo custo podem ser agrupados em clusters, onde exercem funções que exigem alto desempenho computacional como se fossem uma única máquina de grande porte. É correto afirmar que um cluster Beowulf com o sistema operacional Linux é constituído de vários nós escravos,',48,NULL);
INSERT INTO "questao" VALUES (12,'O multiprocessamento simétrico pode ser implementado, por meio de clusters de servidores, usando-se o método secundário ativo, no qual um servidor secundário assume o processamento em caso de falha do servidor primário. Assinale a opção que apresenta corretamente uma justificativa para o uso do método secundário ativo.',50,NULL);
INSERT INTO "questao" VALUES (13,'Assinale a opção que contém uma regra INVÁLIDA para Redes de Petri',53,NULL);
INSERT INTO "questao" VALUES (14,'Sobre o processamento paralelo e distribuído, assinale a afirmação correta.',55,NULL);
INSERT INTO "questao" VALUES (15,'Um sistema distribuído é definido como uma coleção de computadores independentes que se apresenta ao usuário como um sistema único e consistente. Baseado nos conceitos definidos para sistemas distribuídos, identifique a afirmativa ERRADA:',60,NULL);
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
INSERT INTO "disciplina_avaliacao" VALUES (1,2);
INSERT INTO "disciplina_avaliacao" VALUES (2,2);
INSERT INTO "disciplina_avaliacao" VALUES (3,1);
INSERT INTO "disciplina_avaliacao" VALUES (4,3);
INSERT INTO "disciplina_avaliacao" VALUES (5,3);
INSERT INTO "usuario_disciplina" VALUES (1,1);
INSERT INTO "usuario_disciplina" VALUES (1,2);
INSERT INTO "usuario_disciplina" VALUES (2,2);
INSERT INTO "usuario_disciplina" VALUES (2,3);
INSERT INTO "usuario_disciplina" VALUES (3,1);
INSERT INTO "alternativa" VALUES (1,'Apenas I. ',1);
INSERT INTO "alternativa" VALUES (2,'Apenas II. ',1);
INSERT INTO "alternativa" VALUES (3,'Apenas III. ',1);
INSERT INTO "alternativa" VALUES (4,'Apenas I e II.',1);
INSERT INTO "alternativa" VALUES (5,'Apenas II e III. ',1);
INSERT INTO "alternativa" VALUES (6,'quinta forma normal (5FN).',2);
INSERT INTO "alternativa" VALUES (7,'primeira forma normal (1FN).',2);
INSERT INTO "alternativa" VALUES (8,'segunda forma normal (2FN).',2);
INSERT INTO "alternativa" VALUES (9,'terceira forma normal (3FN).',2);
INSERT INTO "alternativa" VALUES (10,'quarta forma normal (4FN).',2);
INSERT INTO "alternativa" VALUES (11,'3FN',3);
INSERT INTO "alternativa" VALUES (12,'2FN',3);
INSERT INTO "alternativa" VALUES (13,'1FN',3);
INSERT INTO "alternativa" VALUES (14,'1FN e 2FN',3);
INSERT INTO "alternativa" VALUES (15,'2FN e 3FN',3);
INSERT INTO "alternativa" VALUES (16,'abstração. ',4);
INSERT INTO "alternativa" VALUES (17,'acoplamento.',4);
INSERT INTO "alternativa" VALUES (18,'encapsulamento.',4);
INSERT INTO "alternativa" VALUES (19,'herança. ',4);
INSERT INTO "alternativa" VALUES (20,'polimorfismo. ',4);
INSERT INTO "alternativa" VALUES (21,'Carlos é um objeto. Tem como métodos andar, correr e pular e, ter 25 anos, ser casado e trabalhar com TICs são variáveis ou estados. ',5);
INSERT INTO "alternativa" VALUES (22,'Andar, correr e pular, são objetos que podem ter como variável Carlos. ',5);
INSERT INTO "alternativa" VALUES (23,'Carlos é uma classe pois há outros Carlos que têm idade diferente de 25 anos e que exercem outras profissões. ',5);
INSERT INTO "alternativa" VALUES (24,'Ter 25 anos, ser casado, andar e correr são estados que podem ser associados ao objeto Carlos. ',5);
INSERT INTO "alternativa" VALUES (25,'Define habilidades e comportamentos de um objeto.',6);
INSERT INTO "alternativa" VALUES (26,'É uma chamada a um objeto para invocar um de seus métodos, ativando um comportamento descrito por sua classe.',6);
INSERT INTO "alternativa" VALUES (27,'É a habilidade de concentrar nos aspectos essenciais de um contexto qualquer, ignorando características menos importantes ou acidentais.',6);
INSERT INTO "alternativa" VALUES (28,'É um mecanismo onde uma classe pode estender uma outra classe, aproveitando seus métodos e atributos.',6);
INSERT INTO "alternativa" VALUES (29,'Este mecanismo é utilizado para impedir o acesso direto aos atributos de um objeto, disponibilizando externamente apenas os métodos que alteram estes atributos.',6);
INSERT INTO "alternativa" VALUES (30,'conter métodos implementados.',7);
INSERT INTO "alternativa" VALUES (31,'ser instanciada diretamente.',7);
INSERT INTO "alternativa" VALUES (32,' possuir um único construtor vazio.',7);
INSERT INTO "alternativa" VALUES (33,'possuir métodos abstratos.',7);
INSERT INTO "alternativa" VALUES (34,'conter variáveis e métodos privados.',7);
INSERT INTO "alternativa" VALUES (35,'Enterprise Business Solutions',8);
INSERT INTO "alternativa" VALUES (36,'Embarcadero Delphi',8);
INSERT INTO "alternativa" VALUES (37,'Eclipises',8);
INSERT INTO "alternativa" VALUES (38,'Komodu',8);
INSERT INTO "alternativa" VALUES (39,'Abstração - Encapsulamento - Concretização - Modelagem',9);
INSERT INTO "alternativa" VALUES (40,'Estruturação - Modulorização - Concretização - Modelagem',9);
INSERT INTO "alternativa" VALUES (41,'Estruturação - Modulorização - Herança - Polimorfismo',9);
INSERT INTO "alternativa" VALUES (42,'Abstração - Encapsulamento - Herança - Polimorfismo',9);
INSERT INTO "alternativa" VALUES (43,'Failback é o processo no qual uma máquina assume os serviços de outra quando esta apresenta alguma falha.',10);
INSERT INTO "alternativa" VALUES (44,'Dependendo da natureza do serviço, executar uma operação de failover significa interromper as transações em andamento, perdendo-as, sendo necessário reiniciá-las após o término do processo',10);
INSERT INTO "alternativa" VALUES (45,'A principal diferença entre clusters assimétricos e simétricos é que no cluster simétrico há a figura de um servidor inativo aguardando uma falha de outro.',10);
INSERT INTO "alternativa" VALUES (46,'sendo que cada nó exerce o controle sobre seu nó vizinho e o último nó exercerá o controle sobre o primeiro nó.',11);
INSERT INTO "alternativa" VALUES (47,'sendo que cada nó exerce seu próprio controle.',11);
INSERT INTO "alternativa" VALUES (48,'controlados por um computador principal.',11);
INSERT INTO "alternativa" VALUES (49,'Caso seja definido que cada servidor utilizará apenas os seus próprios discos, os dados não precisam ser copiados entre os sistemas.',12);
INSERT INTO "alternativa" VALUES (50,'O servidor secundário também pode ser usado para o processamento de outras operações no sistema, além da função de assumir o processamento no caso de falha do servidor primário.',12);
INSERT INTO "alternativa" VALUES (51,'Mesmo quando cada servidor usa apenas os seus próprios discos, o método secundário ativo não exige o gerenciamento do equilíbrio, entre os servidores, das requisições vindas dos clientes.',12);
INSERT INTO "alternativa" VALUES (52,'Um caminho deve iniciar e terminar por um lugar.',13);
INSERT INTO "alternativa" VALUES (53,'Uma transição dispara quando alguma de suas entradas possui uma marcação (token).',13);
INSERT INTO "alternativa" VALUES (54,'Quando uma transição dispara, ela consome uma marcação (token) de cada uma das suas entradas e gera uma para cada saída.',13);
INSERT INTO "alternativa" VALUES (55,'A computação paralela é caracterizada pelo uso de vários processadores para executar uma computação de forma mais rápida, baseando-se no fato de que o processo de resolução de um problema pode ser dividido em tarefas menores, que podem ser realizadas simultaneamente através de algum tipo de coordenação.',14);
INSERT INTO "alternativa" VALUES (56,'A execução de tarefas em um ambiente de processadores distribuídos com acoplamento fraco prevê que a memória seja compartilhada entre os processos trabalhadores.',14);
INSERT INTO "alternativa" VALUES (57,'Em programação paralela não é necessário se conhecer a arquitetura de comunicação entre processadores para elaborar os programas.',14);
INSERT INTO "alternativa" VALUES (58,'Um sistema distribuído fracamente acoplado permite que máquinas e usuários do ambiente sejam fundamentalmente independentes, bem como a interação de forma limitada, quando isto for necessário, compartilhando recursos como discos e impressoras, entre outros.',15);
INSERT INTO "alternativa" VALUES (59,'O modelo de computação distribuída Peer-to-Peer é uma tecnologia que estabelece uma espécie de rede virtual de computadores, onde cada estação tem capacidades e responsabilidades equivalentes.',15);
INSERT INTO "alternativa" VALUES (60,'Uma vantagem dos sistemas distribuídos sobre os sistemas centralizados é a disponibilidade de software para este tipo de ambiente.',15);
INSERT INTO "disciplina" VALUES (1,'BCD29008');
INSERT INTO "disciplina" VALUES (2,'POO29004');
INSERT INTO "disciplina" VALUES (3,'STD29006');
INSERT INTO "usuario" VALUES (1,'Juca','aluno1@email','1234');
INSERT INTO "usuario" VALUES (2,'Luiza','aluno2@email','12345');
INSERT INTO "usuario" VALUES (3,'Rose','aluno3@email','123456');
COMMIT;
