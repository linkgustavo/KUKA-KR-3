# KUKA-KR-3
Modelo e simulação Robô KUKA KR 3 R540 / Modelo y simulación Robot KUKA KR 3 R540

Universidade Federal de Santa Catarina

Engenharia de Controle e Automação

Trabalho 1 - Modelo e simulação Robô KUKA KR 3 R540

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

-170 <= q1 <= 170

0 < q2 <=50

0 < q3 <= 94

-175 < q4 <= 175

-120 < q5 <= 120

0 < q6 <= 180

Essas limitações decorrem da análise feita geometricamente para um conjunto limitado de posturas do manipulador.

Na implementação o cálculo da cinemática inversa é feito para a mesma matriz criada a partir dos ângulos inseridos para o caso da cinemática direta, entretanto a solução pode ser estendida para qualquer postura que contemple os valores acima descritos.

A última ação é o tratamento de erros. Basicamente quando um ou mais ângulos estiverem foram do limite, uma mensagem de erro é apresentada. Caso tudo ocorra normalmente, é impresso para o usuário as coordenadas (X, Y, Z) da cinemática direta, e os ângulos das juntas (θ1, θ2, θ3, θ4, θ5, θ6) da cinemática inversa.


______________________________________________________________________________________________________________________________


Modelo y simulación Robot KUKA KR 3 R540

Universidad Federal de Santa Catarina

Ingeniería de Control y Automatización

Trabajo 1 - Modelo y simulación Robot KUKA KR 3 R540

Profesor: Marcelo Roberto Petry

Alumnos: Christian Correa de Borba <christian962000@hotmail.com>; Gustavo Abiel Link <gustavo_abiel@hotmail.com>

Blumenau, 28 de mayo de 2018.

El código para la realización del trabajo fue implementado en el ambiente Matlab con el auxilio del paquete de bibliotecas para robótica desarrollado por Peter Corke: _Robotics Toolbox_ <http://petercorke.com/wordpress/toolboxes/robotics-toolbox>.

En primer lugar se hace la descripción de la geometría del manipulador antropomórfico utilizando el método de Denavit-Hartenberg y la declaración de los eslabones a través de la sintaxis L (n) = Link ('qlim', [min max], 'offset', w, 'd',, x, 'a', y, 'alpha', z).
De esta forma, un eslabón de revolución limitado por los valores _min_ y _max_ se crea con un offset de _w_ grados y _x_ milímetros, longitud de _y_ milímetros y torsión de _z_ grados.

Para el KUKA KR 3 R540 los seis eslabones fueron declarados siguiendo la convención presentada en el manual de especificaciones, donde la última junta está compuesta por el actuador de Festo.

La sintaxis que crea el robot con las seis juntas rotacionales especificadas es: robo = SerialLink (L, 'name', 'KR 3 R540', 'manufacturer', 'KUKA')

CINEMÁTICA DIRECTA:

Al ejecutar el programa se le pide al usuario que introduzca valores que contemplan el intervalo especificado. Así, las ecuaciones de cinemática directa se crean. Con los ángulos de las juntas insertadas, la función _robo.teach (Q)_ - donde Q es un vector con los ángulos insertados por el usuario - crea una ventana de visualización y permite la manipulación del robot.

CINEMÁTICA INVERSA:

Para la parte de la cinemática inversa un caso particular fue implementado, donde:

-170 <= q1 <= 170

0 < q2 <=50

0 < q3 <= 94

-175 < q4 <= 175

-120 < q5 <= 120

0 < q6 <= 180

Estas limitaciones se derivan del análisis realizado geométricamente para un conjunto limitado de posturas del manipulador.

En la implementación el cálculo de la cinemática inversa se realiza para la misma matriz creada a partir de los ángulos insertados para el caso de la cinemática directa, sin embargo la solución puede ser extendida para cualquier postura que contemple los valores arriba descritos.

La última acción es el tratamiento de errores. Básicamente cuando uno o más ángulos están fuera del límite, se muestra un mensaje de error. En el caso de que todo ocurra normalmente, se imprimen para el usuario las coordenadas (X, Y, Z) de la cinemática directa, y los ángulos de las juntas (θ1, θ2, θ3, θ4, θ5, θ6) de la cinemática inversa.
