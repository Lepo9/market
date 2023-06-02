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
            $sql = 'INSERT INTO oggetto (id_offerente, nome) VALUES (:id_utente, :nome)';
            $stmt = $pdo->prepare($sql);
            $stmt->execute([
                    'id_utente' => $id_utente,
                    'nome'  => 'Nuovo oggetto'
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
        $sql = 'SELECT oggetto.id as id, nome, oggetto.descrizione as descrizione, id_offerente, id_richiedente, immagine,  data_offerta, data_scambio, categoria.descrizione as categoria FROM oggetto, categoria WHERE categoria.id = id_categoria and oggetto.id=:id';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'id' => $id,
            ]
        );
        $row = $stmt->fetch();
        return $row;
    }

    //ottiene i dati di una persona
    public static function getUtente(int $id): array{
        $pdo = Connection::getInstance();
        $sql = 'SELECT id, nome, cognome, email, gettoni FROM utente WHERE id=:id';
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


    public static function newMessaggio(int $id_mittente, int $id_destinatario, string $testo, int $id_oggetto): bool{
        $pdo = Connection::getInstance();
        //inserisce il messaggio se non è ancora stato inserito
        //se il messaggio è nullo
        if ($testo == '')
            return false;
        $sql = 'SELECT id FROM messaggio WHERE id_mittente = :id_mittente AND id_destinatario = :id_destinatario AND testo = :testo AND id_oggetto = :id_oggetto';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'id_mittente' => $id_mittente,
                'id_destinatario' => $id_destinatario,
                'testo' => $testo,
                'id_oggetto' => $id_oggetto,
            ]
        );
        $row = $stmt->fetch();
        if ($row != null)
            return false;
        //inserisce il messaggio
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
        $sql = 'SELECT messaggio.id as id, id_mittente, id_destinatario, testo, messaggio.data as data FROM messaggio WHERE id_oggetto = :id_oggetto ORDER BY messaggio.data ASC';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'id_oggetto' => $id_oggetto,
            ]
        );
        $rows = $stmt->fetchAll();
        return $rows;
    }

    //l'oggetto è ancora vendibile?
    public static function isVendibile(int $id_oggetto): bool{
        $pdo = Connection::getInstance();
        $sql = 'SELECT id_richiedente FROM oggetto WHERE id = :id_oggetto';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'id_oggetto' => $id_oggetto,
            ]
        );
        $row = $stmt->fetch();
        if ($row['id_richiedente'] == null)
            return true;
        return false;
    }

    //funzione che permette di comprare un oggetto
    //verrà sottratto un gettone al compratore e aggiunto uno al venditore
    public static function buyOggetto(int $id_oggetto, int $id_compratore): bool{
        $pdo = Connection::getInstance();
        try {
            //ottengo l'id del venditore
            $sql = 'SELECT id_offerente FROM oggetto WHERE id = :id_oggetto';
            $stmt = $pdo->prepare($sql);
            $stmt->execute([
                    'id_oggetto' => $id_oggetto,
                ]
            );
            $row = $stmt->fetch();
            $id_venditore = $row['id_offerente'];
            //id devono essere diversi
            if ($id_compratore == $id_venditore)
                return false;
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
    public static function getOggettiDisponibili(int $id_current_user): array{
        $pdo = Connection::getInstance();
        $sql = 'SELECT * FROM oggetti_disponibili WHERE id_utente != :idu order by data_offerta desc';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'idu' => $id_current_user
            ]
        );
        $rows = $stmt->fetchAll();
        return $rows;
    }

    public static function getMieiOggetti(int $id_user)
    {
        $pdo = Connection::getInstance();
        $sql = 'SELECT * FROM ogg_off WHERE id_offerente = :idu order by data_offerta desc';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'idu' => $id_user
            ]
        );
        $rows = $stmt->fetchAll();
        return $rows;
    }

    //ottiene tutti i messaggi ricevuti o mandati da un utente per un oggetto
    public static function getMessaggiUtente(int $id_oggetto, int $id_user): array{
        //prendo tutti gli utenti che hanno mandato un messaggio per l'oggetto
        //prendo nome, cognome ed id
        $pdo = Connection::getInstance();
        $sql = 'SELECT DISTINCT utente.id as id, nome, cognome FROM utente, messaggio WHERE utente.id = messaggio.id_mittente AND id_oggetto = :id_oggetto AND id_destinatario = :id_user';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'id_oggetto' => $id_oggetto,
                'id_user' => $id_user
            ]
        );
        $rows = $stmt->fetchAll();
        $utenti = array();
        foreach ($rows as $row){
            $utente = array();
            $utente['id'] = $row['id'];
            $utente['nome'] = $row['nome'];
            $utente['cognome'] = $row['cognome'];
            $utente['messaggi'] = array();
            $utenti[] = $utente;
        }
        //var_dump($utenti);
        //per ogni utente prendo i messaggi
        $data = array();
        foreach ($utenti as $utente) {
            //var_dump($utente);
            //var_dump($id_oggetto);
            $sql = 'SELECT * FROM messaggio WHERE id_oggetto = :id_oggetto AND (id_mittente = :id_utente OR id_destinatario = :id_utente) ORDER BY data ASC';
            $stmt = $pdo->prepare($sql);
            $stmt->execute([
                'id_oggetto' => $id_oggetto,
                'id_utente' => $utente['id'],
            ]);
            $rows = $stmt->fetchAll();
            //stampa messaggi
            foreach ($rows as $row) {
                //var_dump($row);
                $messaggio = array();
                $messaggio['id'] = $row['id'];
                $messaggio['id_mittente'] = $row['id_mittente'];
                $messaggio['id_destinatario'] = $row['id_destinatario'];
                $messaggio['testo'] = $row['testo'];
                $messaggio['data'] = $row['data'];

                $utente['messaggi'][] = $messaggio;
                //var_dump($utente['messaggi']);
            }
            //var_dump($utente);
            $data[$utente['id']] = $utente;
        }
        //var_dump($data);
        return $data;
    }
}