create table categoria
(
    id          int auto_increment
        primary key,
    descrizione text not null
);

create table utente
(
    id       int auto_increment
        primary key,
    nome     varchar(255)                                                                        not null,
    cognome  varchar(255)                                                                        not null,
    email    text         default 'default@email.com'                                            not null,
    password varchar(255) default '$2y$10$A0jP0TvrG8T0VF4h3rcax.a7TY6l2tB7Gv9RTMVPqEQpWm7aC83V.' not null,
    gettoni  int          default 2                                                              not null
);

create table oggetto
(
    id             int auto_increment
        primary key,
    nome           varchar(255) default 'Oggetto generico '            not null,
    descrizione    text         default 'Questo è un oggetto generico' null,
    immagine       text                                                null,
    data_offerta   datetime     default current_timestamp()            not null,
    data_scambio   datetime                                            null,
    id_categoria   int                                                 null,
    id_offerente   int                                                 null,
    id_richiedente int                                                 null,
    constraint oggetto_categoria_id_fk
        foreign key (id_categoria) references categoria (id)
            on update cascade,
    constraint oggetto_utente_id_fk
        foreign key (id_offerente) references utente (id)
            on update cascade on delete set null,
    constraint oggetto_utente_id_fk2
        foreign key (id_richiedente) references utente (id)
            on update cascade on delete set null
);

create table messaggio
(
    id              int auto_increment
        primary key,
    testo           text                            not null,
    data_ora        int default current_timestamp() not null,
    id_oggetto      int                             not null,
    id_mittente     int                             not null,
    id_destinatario int                             not null,
    constraint i
        foreign key (id_destinatario) references utente (id)
            on update cascade on delete cascade,
    constraint messaggio_oggetto_id_fk
        foreign key (id_oggetto) references oggetto (id)
            on update cascade on delete cascade,
    constraint messaggio_utente_id_fk
        foreign key (id_mittente) references utente (id)
            on update cascade on delete cascade
);

create definer = root@localhost view oggetti_disponibili as
select `market`.`oggetto`.`id`            AS `id_oggetto`,
       `market`.`utente`.`id`             AS `id_utente`,
       `market`.`oggetto`.`nome`          AS `nome`,
       `market`.`categoria`.`descrizione` AS `categoria`,
       `market`.`oggetto`.`data_offerta`  AS `data_offerta`,
       `market`.`utente`.`nome`           AS `nomeu`,
       `market`.`utente`.`cognome`        AS `cognomeu`
from `market`.`oggetto`
         join `market`.`categoria`
         join `market`.`utente`
where `market`.`oggetto`.`id_categoria` = `market`.`categoria`.`id`
  and `market`.`oggetto`.`id_offerente` = `market`.`utente`.`id`
  and `market`.`oggetto`.`data_scambio` is null;


