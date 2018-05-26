# KUKA-KR-3
Modelo e simulação Robô KUKA KR 3 R540 / Modelo y simulación Robot KUKA KR 3 R540

Universidade Federal de Santa Catarina

Engenharia de Controle e Automação

Trabalho 1 - Modelo e simulação Robo KUKA KR 3 R540

Professor: Marcelo Roberto Petry

Alunos: Christian Correa de Borba <christian962000@hotmail.com>; Gustavo Abiel Link <gustavo_abiel@hotmail.com>

Blumenau, 28 de maio de 2018.

O código para a realização do trabalho foi implementado no ambiente Matlab com o auxílio do pacote de bibliotecas para robótica desenvolvido por Peter Corke: _Robotics Toolbox_ <http://petercorke.com/wordpress/toolboxes/robotics-toolbox>.

Primeiramente é feita a descrição da geometria do manipulador antropomórfico utilizando o método de Denavit-Hartenberg e declaração dos elos através da sintaxe L(n)=Link('qlim', [min max], 'offset', w, 'd', x, 'a', y, 'alpha', z). 
Desta forma, um elo de revolução limitado pelos valores _min_ e _max_ é criado com um offset de _w_ graus e _x_ milímetros, comprimento de _y_ milímetros e torção de _z_ graus.

Para o KUKA KR 3 R540 os seis elos foram declarados seguindo a convenção apresentada no manual de especificações, onde a última junta é composta pelo atuador da Festo.

A sintaxe que cria o robô com as seis juntas rotacionais especificadas é: robo = SerialLink(L, 'name', 'KR 3 R540', 'manufacturer', 'KUKA')

CINEMÁTICA DIRETA:

Ao executar o programa é pedido ao usuário que insira valores que contemplam o intervalo especificado. Assim, as equações de cinemática direta são criadas. Com os ângulos das juntas inseridos, a função _robo.teach(Q)_ - onde Q é um vetor com os ângulos inseridos pelo usuário - cria uma janela de visualização e permite a manipulação do robô. 

CINEMÁTICA INVERSA:

Para a parte da cinemática inversa um caso particular foi implementado, onde:

-170<=q1<=170

0<q2<=50

0<q3<=94

0<q4<=175

0<q5<=120

0<q6<=180

Essa limitações decorrem da análise feita geometricamente para uma gama limitada de posturas do manipulador


