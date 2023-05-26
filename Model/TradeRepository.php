<?php

namespace Model;
use http\Exception\BadMessageException;
use Util\Connection;

class TradeRepository{

    public static function newOggetto($id_utente): int{
        $pdo = Connection::getInstance();
        try {
            //begin transaction
            $pdo->beginTransaction();
            $sql = 'INSERT INTO oggetto (id_offerente, nome) VALUES (:id_utente, "Nuovo oggetto")';
            $stmt = $pdo->prepare($sql);
            $stmt->execute([
                    'id_utente' => $id_utente
                ]
            );
            //Ritorna l'id dell'oggetto appena creato
            $id_oggetto = $pdo->lastInsertId();
        } catch (PDOException $e) {
            //rollback if something goes wrong
            $pdo->rollBack();
            echo $e->getMessage();
        }
        //commit if everything is ok
        $pdo->commit();
        return $id_oggetto;
    }

    public static function getOggetto(int $id): array{
        $pdo = Connection::getInstance();
        $sql = 'SELECT oggetto.id as id, nome, oggetto.descrizione as descrizione, immagine,  data_offerta, data_scambio, categoria.descrizione as categoria FROM oggetto, categoria WHERE categoria.id = id_categoria and oggetto.id=:id';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'id' => $id,
            ]
        );
        $row = $stmt->fetch();
        return $row;
    }

    public static function setOggetto (int $id, string $nome, string $descrizione, string $immagine, int $id_categoria): bool{
        $pdo = Connection::getInstance();
        $sql = 'UPDATE oggetto SET nome = :nome, descrizione = :descrizione, immagine = :immagine, id_categoria = :id_categoria WHERE id = :id';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'id' => $id,
                'nome' => $nome,
                'descrizione' => $descrizione,
                'immagine' => $immagine,
                'id_categoria' => $id_categoria
            ]
        );
        if ($stmt->rowCount() == 1)
            return true;
        return false;
    }

    public static function canBuy (int $id_user): bool{
        $pdo = Connection::getInstance();
        $sql = 'SELECT gettoni FROM utente WHERE id= :id_user';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'id_user' => $id_user
            ]
        );
        $row = $stmt->fetch();
        if ($row['gettoni'] <=  -2)
            return false;
        return true;
    }

    public static function getCategoria(int $id): string{
        $pdo = Connection::getInstance();
        $sql = 'SELECT descrizione FROM categoria WHERE id = :id';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'id' => $id
            ]
        );
        $row = $stmt->fetch();
        return $row['descrizione'];
    }

    public static function getUtente(int $id): array{
        $pdo = Connection::getInstance();
        $sql = 'SELECT id, nome, cognome, email, gettoni FROM utente WHERE id = :id';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'id' => $id
            ]
        );
        $row = $stmt->fetch();
        return $row;
    }


    public static function newMessaggio(int $id_mittente, int $id_destinatario, string $testo, int $id_oggetto): bool{
        $pdo = Connection::getInstance();
        $sql = 'INSERT INTO messaggio (id_mittente, id_destinatario, testo, id_oggetto) VALUES (:id_mittente, :id_destinatario, :testo, :id_oggetto)';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'id_mittente' => $id_mittente,
                'id_destinatario' => $id_destinatario,
                'testo' => $testo,
                'id_oggetto' => $id_oggetto,
            ]
        );
        if ($stmt->rowCount() == 1)
            return true;
        return false;
    }

    //funzione che permette di ottenere i messaggi relativi ad un oggetto
    public static function getMessaggi(int $id_oggetto): array{
        $pdo = Connection::getInstance();
        $sql = 'SELECT messaggio.id as id, id_mittente, id_destinatario, testo, messaggio.data as data, nome, cognome FROM messaggio, utente WHERE id_oggetto = :id_oggetto and utente.id = messaggio.id_mittente';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'id_oggetto' => $id_oggetto,
            ]
        );
        $rows = $stmt->fetchAll();
        return $rows;
    }


    //funzione che permette di comprare un oggetto
    //verrà sottratto un gettone al compratore e aggiunto uno al venditore
    public static function buyOggetto(int $id_oggetto, int $id_compratore, int $id_venditore): bool{
        $pdo = Connection::getInstance();
        try {
            //begin transaction
            $pdo->beginTransaction();
            $sql = 'UPDATE oggetto SET id_richiedente = :id_compratore, data_scambio = NOW() WHERE id = :id_oggetto';
            $stmt = $pdo->prepare($sql);
            $stmt->execute([
                    'id_oggetto' => $id_oggetto,
                    'id_compratore' => $id_compratore
                ]
            );
            $sql = 'UPDATE utente SET gettoni = gettoni - 1 WHERE id = :id_compratore';
            $stmt = $pdo->prepare($sql);
            $stmt->execute([
                    'id_compratore' => $id_compratore
                ]
            );
            $sql = 'UPDATE utente SET gettoni = gettoni + 1 WHERE id = :id_venditore';
            $stmt = $pdo->prepare($sql);
            $stmt->execute([
                    'id_venditore' => $id_venditore
                ]
            );
        } catch (PDOException $e) {
            //rollback if something goes wrong
            $pdo->rollBack();
            echo $e->getMessage();
        }
        //commit if everything is ok
        $pdo->commit();
        return true;
    }


    //ottengo tutti gli oggetti non ancora scambiati
    public static function getOggettiDisponibili(): array{
        $pdo = Connection::getInstance();
        $sql = 'SELECT * FROM oggetti_disponibili order by data_offerta desc';
        $stmt = $pdo->prepare($sql);
        $stmt->execute();
        $rows = $stmt->fetchAll();
        return $rows;
    }

}