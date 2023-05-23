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
}