<?php

namespace Model;

require 'vendor/autoload.php';
use http\Exception\BadMessageException;
use PDOException;
use Util\Connection;



class TradeRepository{

    public static function newOggetto($id_utente, $nome, $descrizione, $immagine, $id_categoria): bool{
        $pdo = Connection::getInstance();
        try {
            if ($immagine != null)
                $immagine = "./img/" . $immagine;
            $pdo->beginTransaction();
            $sql = 'INSERT INTO oggetto (nome, descrizione, immagine, id_categoria, id_offerente) VALUES (:nome, :descrizione, :immagine, :id_categoria, :id_utente)';
            $stmt = $pdo->prepare($sql);
            $stmt->execute([
                    'nome' => $nome,
                    'descrizione' => $descrizione,
                    'immagine' => $immagine,
                    'id_categoria' => $id_categoria,
                    'id_utente' => $id_utente
                ]
            );
            $pdo->commit();
            return true;
        } catch (BadMessageException $e) {
            var_dump($e);
            $pdo->rollBack();
            return false;
        }
    }

    public static function uploadImage($image): string | null{
       $destination_path = './img/';
        if ($image['error'] === UPLOAD_ERR_OK){
            $nomeFile = $image['name']; // Ottieni il nome originale del file
            $nomeTemporaneo = $image['tmp_name']; // Ottieni il percorso temporaneo del file
            //var_dump(pathinfo($nomeFile, PATHINFO_EXTENSION));
            // Rinomina il file utilizzando l'estensione originale
            $nuovoNome = time() . '.' . pathinfo($nomeFile, PATHINFO_EXTENSION);

            // Specifica il percorso in cui salvare l'immagine ridimensionata
            $percorsoDestinazione = $destination_path . $nuovoNome;

            // Dimensioni desiderate per l'immagine ridimensionata
            $larghezzaDesiderata = 600;
            // Ottieni le dimensioni dell'immagine originale
            list($larghezzaOriginale, $altezzaOriginale) = getimagesize($nomeTemporaneo);

            // Calcola la larghezza proporzionale in base all'altezza desiderata
            $altezzaDesiderata = ($altezzaOriginale / $larghezzaOriginale) * $larghezzaDesiderata;


            // Carica l'immagine originale utilizzando la libreria GD
            if(pathinfo($nomeFile, PATHINFO_EXTENSION) == 'jpeg' || pathinfo($nomeFile, PATHINFO_EXTENSION) == 'jpg')
            $immagine = imagecreatefromjpeg($nomeTemporaneo);
            else if(pathinfo($nomeFile, PATHINFO_EXTENSION) == 'png')
                $immagine = imagecreatefrompng($nomeTemporaneo);
            else
                return null;

            // Crea una nuova immagine ridimensionata
            $immagineRidimensionata = imagescale($immagine, $larghezzaDesiderata, $altezzaDesiderata);

            // Salva l'immagine ridimensionata
            if(pathinfo($nomeFile, PATHINFO_EXTENSION) == 'jpeg' || pathinfo($nomeFile, PATHINFO_EXTENSION) == 'jpg')
                imagejpeg($immagineRidimensionata, $percorsoDestinazione);
            else if(pathinfo($nomeFile, PATHINFO_EXTENSION) == 'png')
                imagepng($immagineRidimensionata, $percorsoDestinazione);
            else
                return null;
            // Libera la memoria
            imagedestroy($immagine);
            imagedestroy($immagineRidimensionata);
            return $nuovoNome;
        }
        else
            return null;
    }

    //ottiene tutte le categorie
    public static function getCategorie(): array{
        $pdo = Connection::getInstance();
        $sql = 'SELECT * FROM categoria order by descrizione asc ';
        $stmt = $pdo->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll();
    }

    public static function deleteOggetto(int $id): bool{
        $pdo = Connection::getInstance();
        try {
            $pdo->beginTransaction();
            //prima vedo se l'oggetto ha un'immagine
            $sql = 'SELECT immagine FROM oggetto WHERE id=:id';
            $stmt = $pdo->prepare($sql);
            $stmt->execute([
                    'id' => $id,
                ]
            );
            $row = $stmt->fetch();
            //se ha un'immagine la elimino
            if ($row['immagine'] != null) {
                unlink($row['immagine']);
            }
            $sql = 'DELETE FROM oggetto WHERE id=:id';
            $stmt = $pdo->prepare($sql);
            $stmt->execute([
                    'id' => $id,
                ]
            );
            $pdo->commit();
            return true;
        } catch (BadMessageException $e) {
            var_dump($e);
            $pdo->rollBack();
            return false;
        }
    }
    public static function getOggetto(int $id): array{
        $pdo = Connection::getInstance();
        $sql = 'SELECT oggetto.id as id, nome, oggetto.descrizione as descrizione, id_offerente, id_richiedente, immagine,  data_offerta, data_scambio, categoria.descrizione as categoria FROM oggetto, categoria WHERE categoria.id = id_categoria and oggetto.id=:id';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'id' => $id,
            ]
        );
        if ($stmt->rowCount() == 0)
            return [];
        return $stmt->fetch();
    }
    public static function getRawOggetto(int $id): array{
        $pdo = Connection::getInstance();
        $sql = 'SELECT * FROM oggetto WHERE id=:id';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'id' => $id,
            ]
        );
        return $stmt->fetch();
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
        return $stmt->fetch();
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

    //funzione che permette di ottenere i messaggi relativi a un oggetto
    public static function getMessaggi(int $id_oggetto): array{
        $pdo = Connection::getInstance();
        $sql = 'SELECT messaggio.id as id, id_mittente, id_destinatario, testo, messaggio.data as data FROM messaggio WHERE id_oggetto = :id_oggetto ORDER BY messaggio.data ASC';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'id_oggetto' => $id_oggetto,
            ]
        );
        return $stmt->fetchAll();
    }

    public static function editOggetto(int $id,  $nome,  $descrizione,  $immagine,  $id_categoria): bool{
        $pdo = Connection::getInstance();
        if (!str_starts_with($immagine, '.')) {
            //elimino l'immagine precedente
            $sql = 'SELECT immagine FROM oggetto WHERE id = :id';
            $stmt = $pdo->prepare($sql);
            $stmt->execute([
                    'id' => $id,
                ]
            );
            $row = $stmt->fetch();
            $im = $row['immagine'];
            unlink($im);
            $immagine = "./img/" . $immagine;
        }

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
        return $stmt->fetchAll();
    }

    public static function getMieiOggetti(int $id_user): bool|array
    {
        $pdo = Connection::getInstance();
        $sql = 'SELECT * FROM ogg_off WHERE id_offerente = :idu order by data_offerta desc';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'idu' => $id_user
            ]
        );
        return $stmt->fetchAll();
    }

    //ottiene tutti i messaggi ricevuti o mandati da un utente per un oggetto
    public static function getMessaggiUtente(int $id_oggetto, int $id_user): array{
        //prendo tutti gli utenti che hanno mandato un messaggio per l'oggetto
        //prendo nome, cognome e id
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

    public static function getOggettiComprati(int $id_user): bool|array
    {
        $pdo = Connection::getInstance();
        $sql = 'SELECT oggetto.id as id, nome, oggetto.descrizione as descrizione, id_offerente, id_richiedente, immagine,  data_offerta, data_scambio, categoria.descrizione as categoria FROM oggetto, categoria WHERE categoria.id = id_categoria and id_richiedente = :idu order by data_offerta desc';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'idu' => $id_user
            ]
        );
        return $stmt->fetchAll();
    }

    public static function getOggettiDisponibiliRicerca(int $id_user, string $search): bool|array
    {
        $pdo = Connection::getInstance();
        $sql = 'SELECT * FROM oggetti_disponibili WHERE id_utente != :idu and (nome like :search) order by data_offerta desc';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'idu' => $id_user,
                'search' => '%'.$search.'%'
            ]
        );
        return $stmt->fetchAll();
    }

    public static function getCompratiRicerca(int $id_user, string $search): bool|array
    {
        $pdo = Connection::getInstance();
        $sql = 'SELECT oggetto.id as id, nome, oggetto.descrizione as descrizione, id_offerente, id_richiedente, immagine,  data_offerta, data_scambio, categoria.descrizione as categoria FROM oggetto, categoria WHERE categoria.id = id_categoria and id_richiedente = :idu and (nome like :search) order by data_offerta desc';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'idu' => $id_user,
                'search' => '%'.$search.'%'
            ]
        );
        return $stmt->fetchAll();
    }

    public static function getMieiOggettiRicerca(mixed $id_user, mixed $search): bool|array
    {
        $pdo = Connection::getInstance();
        $sql = 'SELECT * FROM ogg_off WHERE id_offerente = :idu and (nome like :search) order by data_offerta desc';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'idu' => $id_user,
                'search' => '%'.$search.'%'
            ]
        );
        return $stmt->fetchAll();
    }

    public static function oggettiDisponibiliRicerca(string $search): bool|array
    {
        $pdo = Connection::getInstance();
        $sql = 'SELECT * FROM oggetti_disponibili WHERE (nome like :search) order by data_offerta desc';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'search' => '%'.$search.'%'
            ]
        );
        return $stmt->fetchAll();
    }

    public static function oggettiDisponibili(): bool|array
    {
        $pdo = Connection::getInstance();
        $sql = 'SELECT * FROM oggetti_disponibili order by data_offerta desc';
        $stmt = $pdo->query($sql);
        return $stmt->fetchAll();
    }

}