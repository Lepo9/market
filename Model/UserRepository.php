<?php

namespace Model;
use Util\Connection;

class UserRepository{

    public static function userAuthentication(string $email, string $password):array|null{
        $pdo = Connection::getInstance();
        $sql = 'SELECT * FROM utente WHERE email=:email';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'email' => $email
            ]
        );
        //Non esiste un utente con quello username nel database
        if($stmt->rowCount() == 0)
            return null;
        //Recupera i dati dell'utente
        $row = $stmt->fetch();
        //Verifica che la password corrisponda
        //Se non corrisponde ritorna null
        if (!password_verify($password, $row['password']))
            return null;
        //Altrimenti ritorna il vettore contenente i dati dell'utente
        return $row;
    }

    public static function emailInUso(string $email):bool{
        $pdo = Connection::getInstance();
        $sql = 'SELECT * FROM utente WHERE email=:email';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
                'email' => $email
            ]
        );
        //Non esiste un utente con quello username nel database
        if($stmt->rowCount() == 0)
            return false;
        return true;
    }


    public static function newUtente(string $nome, string $cognome, string $email, string $password1):bool{
        //la password viene criptata
        $password = password_hash($password1, PASSWORD_DEFAULT);
        $pdo = Connection::getInstance();
        $sql = 'INSERT INTO utente (nome, cognome, email, password) VALUES (:nome, :cognome, :email, :password)';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            'nome' => $nome,
            'cognome' => $cognome,
            'email' => $email,
            'password' => $password
        ]);
        if ($stmt->rowCount() == 0)
            return false;
        return true;
    }

}