REATE TABLE usuarios (
 usuario_id NUMBER PRIMARY KEY,
 nombre VARCHAR2(100),
 correo VARCHAR2(150)
);

INSERT INTO usuarios VALUES (1, 'Ana López', 'ana@correo.com');
INSERT INTO usuarios VALUES (2, 'Carlos Ruiz', 'carlos@correo.com');
INSERT INTO usuarios VALUES (3, 'Diana Gómez', 'diana@correo.com');
INSERT INTO usuarios VALUES (4, 'Fernando Pérez', 'fernando@correo.com');
INSERT INTO usuarios VALUES (5, 'Lucía Torres', 'lucia@correo.com');
INSERT INTO usuarios VALUES (6, 'Marcos Salas', 'marcos@correo.com');
INSERT INTO usuarios VALUES (7, 'Patricia Vega', 'patricia@correo.com');
INSERT INTO usuarios VALUES (8, 'Raúl Mendoza', 'raul@correo.com');
INSERT INTO usuarios VALUES (9, 'Silvia Castro', 'silvia@correo.com');
INSERT INTO usuarios VALUES (10, 'Tomás Fuentes', 'tomas@correo.com');

CREATE TABLE incidentes (
 incidente_id NUMBER PRIMARY KEY,
 descripcion VARCHAR2(200),
 criticidad VARCHAR2(20)
);

INSERT INTO incidentes VALUES (1, 'No enciende el equipo', 'Alta');
INSERT INTO incidentes VALUES (2, 'No hay internet', 'Media');
INSERT INTO incidentes VALUES (3, 'Pantalla azul', 'Alta');
INSERT INTO incidentes VALUES (4, 'No imprime', 'Baja');
INSERT INTO incidentes VALUES (5, 'Virus detectado', 'Alta');
INSERT INTO incidentes VALUES (6, 'Lentitud en sistema', 'Media');
INSERT INTO incidentes VALUES (7, 'Error al abrir app', 'Media');
INSERT INTO incidentes VALUES (8, 'Mouse no responde', 'Baja');
INSERT INTO incidentes VALUES (9, 'Teclado da doble letra', 'Baja');
INSERT INTO incidentes VALUES (10, 'Desbloqueo de cuenta', 'Media');

CREATE TABLE tickets (
 ticket_id NUMBER PRIMARY KEY,
 usuario_id NUMBER,
 incidente_id NUMBER,
 fecha_apertura TIMESTAMP DEFAULT SYSTIMESTAMP,
 estado VARCHAR2(20),
 FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id),
 FOREIGN KEY (incidente_id) REFERENCES incidentes(incidente_id)
);
INSERT INTO tickets VALUES (1, 1, 1, SYSTIMESTAMP, 'Abierto');
INSERT INTO tickets VALUES (2, 2, 2, SYSTIMESTAMP, 'Cerrado');
INSERT INTO tickets VALUES (3, 3, 3, SYSTIMESTAMP, 'Abierto');
INSERT INTO tickets VALUES (4, 4, 4, SYSTIMESTAMP, 'Abierto');
INSERT INTO tickets VALUES (5, 5, 5, SYSTIMESTAMP, 'Cerrado');
INSERT INTO tickets VALUES (6, 6, 6, SYSTIMESTAMP, 'Abierto');
INSERT INTO tickets VALUES (7, 7, 7, SYSTIMESTAMP, 'Cerrado');
INSERT INTO tickets VALUES (8, 8, 8, SYSTIMESTAMP, 'Abierto');
INSERT INTO tickets VALUES (9, 9, 9, SYSTIMESTAMP, 'Cerrado');
INSERT INTO tickets VALUES (10, 10, 10, SYSTIMESTAMP, 'Abierto');

CREATE TABLE chat_ia (
 chat_id NUMBER PRIMARY KEY,
 ticket_id NUMBER,
 mensaje VARCHAR2(300),
 quien VARCHAR2(20),
 fecha TIMESTAMP DEFAULT SYSTIMESTAMP,
 FOREIGN KEY (ticket_id) REFERENCES tickets(ticket_id)
);
INSERT INTO chat_ia VALUES (1, 1, 'Hola, ¿puedes describir el problema?', 'IA',
SYSTIMESTAMP);
INSERT INTO chat_ia VALUES (2, 1, 'No enciende mi computadora', 'usuario',
SYSTIMESTAMP);
INSERT INTO chat_ia VALUES (3, 2, '¿Tienes el router conectado?', 'IA', SYSTIMESTAMP);
INSERT INTO chat_ia VALUES (4, 2, 'Sí, pero no hay señal', 'usuario', SYSTIMESTAMP);
INSERT INTO chat_ia VALUES (5, 3, '¿Te sale algún código de error?', 'IA',
SYSTIMESTAMP);
INSERT INTO chat_ia VALUES (6, 4, '¿Ya revisaste el papel en la impresora?', 'IA',
SYSTIMESTAMP);
INSERT INTO chat_ia VALUES (7, 5, 'Se detectó un virus, actualizando antivirus.', 'IA',
SYSTIMESTAMP);
INSERT INTO chat_ia VALUES (8, 6, '¿Qué aplicación va lenta?', 'IA', SYSTIMESTAMP);
INSERT INTO chat_ia VALUES (9, 7, 'Reinstala la app y reinicia.', 'IA', SYSTIMESTAMP);
INSERT INTO chat_ia VALUES (10, 8, 'Prueba otro puerto USB.', 'IA', SYSTIMESTAMP);

CREATE TABLE soluciones (
 solucion_id NUMBER PRIMARY KEY,
 ticket_id NUMBER,
 solucion_texto VARCHAR2(300),
 aplicada_por VARCHAR2(20),
 fecha TIMESTAMP DEFAULT SYSTIMESTAMP,
 FOREIGN KEY (ticket_id) REFERENCES tickets(ticket_id)
);

INSERT INTO soluciones VALUES (1, 1, 'Se cambió la fuente de poder.', 'Técnico',
SYSTIMESTAMP);
INSERT INTO soluciones VALUES (2, 2, 'Se reinició el módem.', 'IA', SYSTIMESTAMP);
INSERT INTO soluciones VALUES (3, 3, 'Actualización de drivers.', 'IA', SYSTIMESTAMP);
INSERT INTO soluciones VALUES (4, 4, 'Colocación de nuevo cartucho.', 'Técnico',
SYSTIMESTAMP);
INSERT INTO soluciones VALUES (5, 5, 'Limpieza de archivos infectados.', 'IA',
SYSTIMESTAMP);
INSERT INTO soluciones VALUES (6, 6, 'Optimización del sistema.', 'IA', SYSTIMESTAMP);
INSERT INTO soluciones VALUES (7, 7, 'Actualización del software.', 'Técnico',
SYSTIMESTAMP);
INSERT INTO soluciones VALUES (8, 8, 'Cambio de puerto USB.', 'IA', SYSTIMESTAMP);
INSERT INTO soluciones VALUES (9, 9, 'Revisión del teclado.', 'Técnico', SYSTIMESTAMP);
INSERT INTO soluciones VALUES (10, 10, 'Reset de credenciales.', 'IA', SYSTIMESTAMP);

/*VISTAS NORMALES*/
/*Crea una vista que muestre el nombre del usuario, la descripción del incidente y 
 el estado del ticket, solo para tickets que están abiertos.*/

CREATE OR REPLACE VIEW C##ACTCLASE123.Vista1 AS 
SELECT 
  u.nombre AS nombre_usuario,
  i.descripcion AS descripcion_incidente,
  t.estado AS estado_tiket
FROM 
  C##ACTCLASE123.usuarios u
JOIN 
  C##ACTCLASE123.tickets t ON u.usuario_id = t.usuario_id
JOIN 
  C##ACTCLASE123.incidentes i ON t.incidente_id = i.incidente_id
WHERE 
  t.estado = 'Abierto';

SELECT * FROM C##ACTCLASE123.Vista1;

/*Crea una vista que liste el historial del chat, mostrando el nombre del usuario, 
 el mensaje, quién lo dijo y la fecha.*/

CREATE OR REPLACE VIEW C##ACTCLASE123.Vista2 AS 
SELECT 
  usuario.nombre AS nombre,
  chat.mensaje AS mensaje, 
  chat.quien AS quien_lo_dijo,
  chat.fecha AS fecha
FROM 
  C##ACTCLASE123.usuarios usuario
JOIN 
  C##ACTCLASE123.tickets ticket ON usuario.usuario_id = ticket.usuario_id
JOIN 
  C##ACTCLASE123.chat_ia chat ON ticket.ticket_id = chat.ticket_id;
	
SELECT * FROM C##ACTCLASE123.Vista2;

/*Crea una vista que muestre las soluciones aplicadas por IA, con el ticket, 
 la descripción del incidente y el texto de la solución.*/

CREATE OR REPLACE VIEW C##ACTCLASE123.Vista3 AS
SELECT 
  s.ticket_id,
  i.descripcion AS descripcion_incidente,
  s.solucion_texto AS solucion
FROM 
  C##ACTCLASE123.soluciones s
JOIN 
  C##ACTCLASE123.tickets t ON s.ticket_id = t.ticket_id
JOIN 
  C##ACTCLASE123.incidentes i ON t.incidente_id = i.incidente_id
WHERE 
  s.aplicada_por = 'IA';

SELECT * FROM C##ACTCLASE123.Vista3;		 

/*VISTAS MATERIALIZADAS*/
/*Crea una vista materializada que guarde los tickets cerrados con el nombre del 
 usuario y criticidad del incidente.*/
/*Manda error de que los privilegios son insuficientes*/

CREATE MATERIALIZED VIEW C##ACTCLASE123.VistaTicketsCerrados
BUILD IMMEDIATE
REFRESH COMPLETE
AS
SELECT 
  t.ticket_id,
  u.nombre AS nombre_usuario,
  i.criticidad AS criticidad_incidente
FROM 
  C##ACTCLASE123.tickets t
JOIN 
  C##ACTCLASE123.usuarios u ON t.usuario_id = u.usuario_id
JOIN 
  C##ACTCLASE123.incidentes i ON t.incidente_id = i.incidente_id
WHERE 
  t.estado = 'Cerrado';

/*Crea una vista materializada que muestre todas las soluciones aplicadas por técnicos, 
 con su fecha y ticket asociado.*/
/*El mismo error privilegios insuficientes*/

CREATE MATERIALIZED VIEW VistaSolucionesTecnico
BUILD IMMEDIATE
REFRESH ON DEMAND
AS
SELECT 
  ticket_id,
  fecha,
  solucion_texto
FROM 
  soluciones
WHERE 
  aplicada_por = 'Técnico';

/*Crea una vista materializada que muestre el total de tickets abiertos y
 cerrados agrupado por criticidad del incidente.*/
/*Ninguna Materializada me corrio, por el mismo motivo de los privilegios*/

CREATE MATERIALIZED VIEW C##ACTCLASE123.VistaResumenTickets
BUILD IMMEDIATE
REFRESH ON DEMAND
AS
SELECT 
  i.criticidad,
  COUNT(CASE WHEN t.estado = 'Abierto' THEN 1 END) AS total_abiertos,
  COUNT(CASE WHEN t.estado = 'Cerrado' THEN 1 END) AS total_cerrados
FROM 
  C##ACTCLASE123.tickets t
JOIN 
  C##ACTCLASE123.incidentes i ON t.incidente_id = i.incidente_id
GROUP BY 
  i.criticidad;

/*TRIGGERS*/
/*Crea un trigger que al insertar una nueva solución, inserte automáticamente 
 un mensaje en chat_ia diciendo “Solución aplicada: texto_solución”.*/

CREATE OR REPLACE TRIGGER C##ACTCLASE123.tr_solucion_chat
AFTER INSERT ON C##ACTCLASE123.soluciones
FOR EACH ROW
BEGIN
  INSERT INTO C##ACTCLASE123.chat_ia (
    chat_id,
    ticket_id,
    mensaje,
    quien,
    fecha
  )
  VALUES (
    (SELECT NVL(MAX(chat_id), 0) + 1 FROM C##ACTCLASE123.chat_ia),
    :NEW.ticket_id,
    'Solución aplicada: ' || :NEW.solucion_texto,
    'IA',
    SYSTIMESTAMP
  );
END;

/*Consulta*/

SELECT * FROM C##ACTCLASE123.chat_ia WHERE ticket_id = 1 ORDER BY chat_id DESC;

/*Crea un trigger que al cambiar el estado del ticket a “Cerrado”, 
 inserte en chat_ia un mensaje automático diciendo “Ticket cerrado”.*/

CREATE OR REPLACE TRIGGER C##ACTCLASE123.tr_ticket_cerrado_chat
AFTER UPDATE ON C##ACTCLASE123.tickets
FOR EACH ROW
WHEN (NEW.estado = 'Cerrado' AND OLD.estado != 'Cerrado')
BEGIN
  INSERT INTO C##ACTCLASE123.chat_ia (
    chat_id,
    ticket_id,
    mensaje,
    quien,
    fecha
  )
  VALUES (
    (SELECT NVL(MAX(chat_id), 0) + 1 FROM C##ACTCLASE123.chat_ia),
    :NEW.ticket_id,
    'Ticket cerrado',
    'IA',
    SYSTIMESTAMP
  );
END;

/*Consulta*/

SELECT * FROM C##ACTCLASE123.chat_ia WHERE ticket_id = 1 ORDER BY chat_id DESC;

/*Crea un trigger que prohíba (usando RAISE_APPLICATION_ERROR) insertar tickets con estado diferente a “Abierto” o “Cerrado”.*/

CREATE OR REPLACE TRIGGER C##ACTCLASE123.tr_validar_estado_ticket
BEFORE INSERT ON C##ACTCLASE123.tickets
FOR EACH ROW
BEGIN
  IF :NEW.estado NOT IN ('Abierto', 'Cerrado') THEN
    RAISE_APPLICATION_ERROR(-20001, 'El estado del ticket debe ser "Abierto" o "Cerrado".');
  END IF;
END;

/*FUNCIONES*/
/*Crea una función que reciba un ticket_id y devuelva el estado actual del ticket.*/

CREATE OR REPLACE FUNCTION C##ACTCLASE123.obtener_estado_ticket (
  p_ticket_id IN NUMBER
) RETURN VARCHAR2
IS
  v_estado VARCHAR2(20);
BEGIN
  SELECT estado
  INTO v_estado
  FROM C##ACTCLASE123.tickets
  WHERE ticket_id = p_ticket_id;

  RETURN v_estado;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN NULL;
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20002, 'Error al obtener el estado del ticket.');
END;

/*Consulta*/

SELECT C##ACTCLASE123.obtener_estado_ticket(1) AS estado FROM dual;

/*Crea una función que reciba un usuario_id y devuelva el total de tickets que ha reportado ese usuario.*/

CREATE OR REPLACE FUNCTION C##ACTCLASE123.total_tickets_usuario (
  p_usuario_id IN NUMBER
) RETURN NUMBER
IS
  v_total NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO v_total
  FROM C##ACTCLASE123.tickets
  WHERE usuario_id = p_usuario_id;

  RETURN v_total;
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20003, 'Error al contar los tickets del usuario.');
END;

/*Consulta*/

SELECT C##ACTCLASE123.total_tickets_usuario(1) AS total FROM dual;

/*Crea una función que reciba un ticket_id y regrese un texto concatenado que diga:"Usuario: nombre - Incidente: descripción - Estado: estado"*/

CREATE OR REPLACE FUNCTION C##ACTCLASE123.descripcion_ticket (
  p_ticket_id IN NUMBER
) RETURN VARCHAR2
IS
  v_resultado VARCHAR2(500);
BEGIN
  SELECT 
    'Usuario: ' || u.nombre || ' - Incidente: ' || i.descripcion || ' - Estado: ' || t.estado
  INTO 
    v_resultado
  FROM 
    C##ACTCLASE123.tickets t
  JOIN 
    C##ACTCLASE123.usuarios u ON t.usuario_id = u.usuario_id
  JOIN 
    C##ACTCLASE123.incidentes i ON t.incidente_id = i.incidente_id
  WHERE 
    t.ticket_id = p_ticket_id;

  RETURN v_resultado;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'No existe el ticket con ID ' || p_ticket_id;
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20004, 'Error al obtener la descripción del ticket.');
END;

/*Consulta*/

SELECT C##ACTCLASE123.descripcion_ticket(1) AS detalle FROM dual;

/*PROCEDIMIENTOS*/
/*Crea un procedimiento que reciba el usuario_id, incidente_id y estado, e inserte un nuevo ticket en la tabla tickets.*/

CREATE OR REPLACE PROCEDURE C##ACTCLASE123.insertar_ticket (
  p_usuario_id IN NUMBER,
  p_incidente_id IN NUMBER,
  p_estado IN VARCHAR2
)
IS
  v_ticket_id NUMBER;
BEGIN
  -- Generar nuevo ticket_id
  SELECT NVL(MAX(ticket_id), 0) + 1 INTO v_ticket_id FROM C##ACTCLASE123.tickets;

  -- Insertar nuevo ticket
  INSERT INTO C##ACTCLASE123.tickets (
    ticket_id,
    usuario_id,
    incidente_id,
    fecha_apertura,
    estado
  ) VALUES (
    v_ticket_id,
    p_usuario_id,
    p_incidente_id,
    SYSTIMESTAMP,
    p_estado
  );

  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20005, 'Error al insertar el ticket: ' || SQLERRM);
END;

/*Consulta*/

BEGIN
  C##ACTCLASE123.insertar_ticket(1, 3, 'Abierto');
END;

/*Crea un procedimiento que reciba un ticket_id y cambie su estado a “Cerrado”.*/

CREATE OR REPLACE PROCEDURE C##ACTCLASE123.cerrar_ticket (
  p_ticket_id IN NUMBER
)
AS
BEGIN
  UPDATE C##ACTCLASE123.tickets
  SET estado = 'Cerrado'
  WHERE ticket_id = p_ticket_id;
  
  COMMIT;
END;

/*Esto cambiará el estado del ticket con ID 3 a "Cerrado".*/
BEGIN
  C##ACTCLASE123.cerrar_ticket(3);
END;

/*Crea un procedimiento que inserte una nueva solución recibiendo: ticket_id, solucion_texto y aplicada_por.*/

CREATE OR REPLACE PROCEDURE C##ACTCLASE123.insertar_solucion (
  p_ticket_id IN NUMBER,
  p_solucion_texto IN VARCHAR2,
  p_aplicada_por IN VARCHAR2
)
AS
  v_solucion_id NUMBER;
BEGIN
  -- Generar nuevo solucion_id
  SELECT NVL(MAX(solucion_id), 0) + 1 INTO v_solucion_id FROM C##ACTCLASE123.soluciones;

  -- Insertar nueva solución
  INSERT INTO C##ACTCLASE123.soluciones (
    solucion_id,
    ticket_id,
    solucion_texto,
    aplicada_por,
    fecha
  ) VALUES (
    v_solucion_id,
    p_ticket_id,
    p_solucion_texto,
    p_aplicada_por,
    SYSTIMESTAMP
  );

  COMMIT;
END;

/*Esto insertará una solución para el ticket con ID 1, con el texto y aplicado por el técnico.*/

BEGIN
  C##ACTCLASE123.insertar_solucion(1, 'Se actualizó el software.', 'Técnico');
END;

/*INNER JOIN*/
/*Muestra el nombre del usuario y el estado del ticket, solo para los tickets que tienen usuario asignado.*/

CREATE OR REPLACE PROCEDURE C##ACTCLASE123.insertar_solucion (
  p_ticket_id      IN NUMBER,
  p_solucion_texto IN VARCHAR2,
  p_aplicada_por   IN VARCHAR2
)
AS
  v_solucion_id NUMBER;
  v_existe      NUMBER;
BEGIN
  -- Validar que el ticket exista haciendo un INNER JOIN (como parte del SELECT)
  SELECT COUNT(*)
  INTO v_existe
  FROM C##ACTCLASE123.tickets t
  INNER JOIN C##ACTCLASE123.usuarios u ON t.usuario_id = u.usuario_id
  WHERE t.ticket_id = p_ticket_id;

  IF v_existe = 0 THEN
    RAISE_APPLICATION_ERROR(-20010, 'El ticket no existe o no tiene usuario asignado.');
  END IF;

  -- Generar nuevo solucion_id
  SELECT NVL(MAX(solucion_id), 0) + 1 INTO v_solucion_id FROM C##ACTCLASE123.soluciones;

  -- Insertar la nueva solución
  INSERT INTO C##ACTCLASE123.soluciones (
    solucion_id,
    ticket_id,
    solucion_texto,
    aplicada_por,
    fecha
  ) VALUES (
    v_solucion_id,
    p_ticket_id,
    p_solucion_texto,
    p_aplicada_por,
    SYSTIMESTAMP
  );

  COMMIT;
END;

/*Como usar*/
BEGIN
  C##ACTCLASE123.insertar_solucion(5, 'Se cambió la tarjeta madre.', 'Técnico');
END;

/*Muestra el ticket_id, la criticidad del incidente y el nombre del usuario de todos los tickets que tienen incidente y usuario registrado.*/

CREATE OR REPLACE VIEW C##ACTCLASE123.vw_tickets_usuarios_incidentes AS
SELECT 
  t.ticket_id,
  i.criticidad,
  u.nombre AS nombre_usuario
FROM 
  C##ACTCLASE123.tickets t
INNER JOIN 
  C##ACTCLASE123.incidentes i ON t.incidente_id = i.incidente_id
INNER JOIN 
  C##ACTCLASE123.usuarios u ON t.usuario_id = u.usuario_id;

/*Consulta*/
SELECT * FROM C##ACTCLASE123.vw_tickets_usuarios_incidentes;

/*Muestra el mensaje del chat, quién lo dijo y la solución aplicada solo si existe una solución para ese ticket.*/

CREATE OR REPLACE VIEW C##ACTCLASE123.vw_chat_y_solucion AS
SELECT
    c.ticket_id,
    c.mensaje,
    c.quien AS quien_lo_dijo,
    s.solucion_texto AS solucion_aplicada
FROM
    C##ACTCLASE123.chat_ia c
INNER JOIN
    C##ACTCLASE123.soluciones s ON c.ticket_id = s.ticket_id;

/*Consulta*/
SELECT * FROM C##ACTCLASE123.vw_chat_y_solucion;

/*LEFT JOIN*/
/*Lista todos los usuarios con su estado del ticket, aunque no tengan tickets abiertos o cerrados.*/
CREATE OR REPLACE VIEW C##ACTCLASE123.vw_usuarios_tickets_estado AS
SELECT
    u.usuario_id,
    u.nombre AS nombre_usuario,
    t.ticket_id,
    t.estado AS estado_ticket
FROM
    C##ACTCLASE123.usuarios u
LEFT JOIN
    C##ACTCLASE123.tickets t ON u.usuario_id = t.usuario_id;

/*Consulta*/
SELECT * FROM C##ACTCLASE123.vw_usuarios_tickets_estado;

/*Muestra la descripción del incidente junto con el estado del ticket, asegurándote que se muestren todos los incidentes, tengan o no ticket asociado.*/

CREATE OR REPLACE VIEW C##ACTCLASE123.vw_incidentes_con_tickets AS
SELECT
    i.incidente_id,
    i.descripcion,
    t.ticket_id,
    t.estado
FROM
    C##ACTCLASE123.incidentes i
LEFT JOIN
    C##ACTCLASE123.tickets t ON i.incidente_id = t.incidente_id;

/*Consulta*/
SELECT * FROM C##ACTCLASE123.vw_incidentes_con_tickets;

/*Muestra todos los tickets con la posible solución aplicada, aunque algunos tickets aún no tengan solución.*/

CREATE OR REPLACE VIEW C##ACTCLASE123.vw_tickets_con_solucion AS
SELECT
    t.ticket_id,
    t.estado,
    t.incidente_id,
    s.solucion_texto,
    s.aplicada_por
FROM
    C##ACTCLASE123.tickets t
LEFT JOIN
    C##ACTCLASE123.soluciones s ON t.ticket_id = s.ticket_id;
/*Consulta*/
SELECT * FROM C##ACTCLASE123.vw_tickets_con_solucion;

/*RIGHT JOIN*/
/*Muestra todos los tickets con el nombre del usuario, incluyendo aquellos tickets que pueden existir sin tener usuario asignado (simulado).*/

CREATE OR REPLACE VIEW C##ACTCLASE123.vw_tickets_con_usuarios_simulados AS
SELECT
    t.ticket_id,
    t.estado,
    t.incidente_id,
    u.usuario_id,
    u.nombre AS nombre_usuario
FROM
    C##ACTCLASE123.usuarios u
RIGHT JOIN
    C##ACTCLASE123.tickets t ON u.usuario_id = t.usuario_id;

/*Consulta*/
SELECT * FROM C##ACTCLASE123.vw_tickets_con_usuarios_simulados;

/*Lista todos los chats y muestra el mensaje junto con el estado del ticket, 
 asegurando que aparezcan todos los chats, incluso si algún ticket estuviera eliminado.*/

CREATE OR REPLACE VIEW C##ACTCLASE123.vw_chats_con_estado_ticket AS
SELECT
    c.chat_id,
    c.mensaje,
    c.quien,
    c.fecha,
    c.ticket_id,
    t.estado AS estado_ticket
FROM
    C##ACTCLASE123.chat_ia c
LEFT JOIN
    C##ACTCLASE123.tickets t ON c.ticket_id = t.ticket_id;

/*Consulta*/
SELECT * FROM C##ACTCLASE123.vw_chats_con_estado_ticket;

/*Muestra las soluciones junto con el nombre del usuario, asegurando que aparezcan todas las soluciones, 
 aunque el usuario no exista (caso teórico).*/

CREATE OR REPLACE VIEW C##ACTCLASE123.vw_soluciones_con_usuario AS
SELECT
    s.solucion_id,
    s.ticket_id,
    s.solucion_texto,
    s.aplicada_por,
    t.usuario_id,
    u.nombre AS nombre_usuario
FROM
    C##ACTCLASE123.soluciones s
LEFT JOIN
    C##ACTCLASE123.tickets t ON s.ticket_id = t.ticket_id
LEFT JOIN
    C##ACTCLASE123.usuarios u ON t.usuario_id = u.usuario_id;

/*Consulta*/
SELECT * FROM C##ACTCLASE123.vw_soluciones_con_usuario;

/*FULL OUTER JOIN*/
/*Muestra todos los usuarios y tickets, aunque no existan registros relacionados entre ellos.*/

CREATE OR REPLACE VIEW C##ACTCLASE123.vw_usuarios_y_tickets AS
SELECT
    u.usuario_id,
    u.nombre AS nombre_usuario,
    t.ticket_id,
    t.estado AS estado_ticket,
    t.incidente_id
FROM
    C##ACTCLASE123.usuarios u
FULL OUTER JOIN
    C##ACTCLASE123.tickets t ON u.usuario_id = t.usuario_id;

/*Consulta*/

SELECT * FROM C##ACTCLASE123.vw_usuarios_y_tickets;

/*Muestra todos los incidentes y tickets, para ver qué incidentes tienen tickets y cuáles no, 
 o qué tickets están asociados a incidentes que podrían no existir.*/

CREATE OR REPLACE VIEW C##ACTCLASE123.vw_incidentes_tickets_completo AS
SELECT
    i.incidente_id,
    i.descripcion AS descripcion_incidente,
    t.ticket_id,
    t.estado AS estado_ticket,
    t.usuario_id
FROM
    C##ACTCLASE123.incidentes i
FULL OUTER JOIN
    C##ACTCLASE123.tickets t ON i.incidente_id = t.incidente_id;

/*Consulta*/

SELECT * FROM C##ACTCLASE123.vw_incidentes_tickets_completo;

/*Muestra todas las soluciones y chats, aunque no tengan relación directa, para revisar integridad.*/

CREATE OR REPLACE VIEW C##ACTCLASE123.vw_soluciones_chats_integridad AS
SELECT
  s.solucion_id,
  s.ticket_id AS solucion_ticket_id,
  s.solucion_texto,
  s.aplicada_por,
  s.fecha AS fecha_solucion,
  c.chat_id,
  c.ticket_id AS chat_ticket_id,
  c.mensaje,
  c.quien,
  c.fecha AS fecha_chat
FROM
  C##ACTCLASE123.soluciones s
FULL OUTER JOIN
  C##ACTCLASE123.chat_ia c ON s.ticket_id = c.ticket_id;

/*Consulta*/
SELECT * FROM C##ACTCLASE123.vw_soluciones_chats_integridad;