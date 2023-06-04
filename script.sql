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
    nome     varchar(255)                            not null,
    cognome  varchar(255)                            not null,
    email    text         default 'default@mail.com' not null,
    password varchar(255) default 'a'                not null,
    gettoni  int          default 2                  not null
);

create table oggetto
(
    id             int auto_increment
        primary key,
    nome           varchar(255)                         not null,
    descrizione    text                                 null,
    immagine       text                                 null,
    data_offerta   datetime default current_timestamp() not null,
    data_scambio   datetime                             null,
    id_categoria   int                                  not null,
    id_offerente   int                                  null,
    id_richiedente int                                  null,
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
    testo           text                                 not null,
    data            datetime default current_timestamp() not null,
    id_oggetto      int                                  not null,
    id_mittente     int                                  not null,
    id_destinatario int                                  not null,
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

create definer = root@localhost view ogg_off as
select `trade`.`oggetto`.`id`             AS `id_oggetto`,
       `trade`.`oggetto`.`id_offerente`   AS `id_offerente`,
       `trade`.`oggetto`.`nome`           AS `nome`,
       `trade`.`oggetto`.`data_offerta`   AS `data_offerta`,
       `trade`.`oggetto`.`data_scambio`   AS `data_scambio`,
       `trade`.`categoria`.`descrizione`  AS `categoria`,
       `trade`.`oggetto`.`id_richiedente` AS `id_richiedente`
from `trade`.`utente`
         join `trade`.`categoria`
         join `trade`.`oggetto`
where `trade`.`utente`.`id` = `trade`.`oggetto`.`id_offerente`
  and `trade`.`categoria`.`id` = `trade`.`oggetto`.`id_categoria`;

create definer = root@localhost view oggetti_disponibili as
select `trade`.`oggetto`.`id`            AS `id_oggetto`,
       `trade`.`utente`.`id`             AS `id_utente`,
       `trade`.`oggetto`.`nome`          AS `nome`,
       `trade`.`oggetto`.`data_offerta`  AS `data_offerta`,
       `trade`.`utente`.`nome`           AS `nomeu`,
       `trade`.`utente`.`cognome`        AS `cognomeu`,
       `trade`.`categoria`.`descrizione` AS `categoria`
from `trade`.`oggetto`
         join `trade`.`utente`
         join `trade`.`categoria`
where `trade`.`utente`.`id` = `trade`.`oggetto`.`id_offerente`
  and `trade`.`categoria`.`id` = `trade`.`oggetto`.`id_categoria`
  and `trade`.`oggetto`.`data_scambio` is null;


