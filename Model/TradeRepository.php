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
        $sql = 'SELECT * FROM oggetto, WHERE id=:id';
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
        $sql = 'SELECT nome, cognome, email, gettoni FROM utente WHERE id = :id';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'id' => $id
            ]
        );
        $row = $stmt->fetch();
        return $row;
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