<?php

namespace Util;

use Model\UserRepository;

/**
 * Classe per gestire l'autenticazione
 */
class Authenticator{

    private function __construct()
    {
    }

    /**

     */
    private static function start(): void
    {
        if (session_id() == "")
            session_start();
    }

    public static function getUser():array|bool{
        self::start();
        //Controllo se è in corso un tentativo di login
        //verificando la presenza dello username spedito tramite POST
        if (isset($_POST['email'])){
            $email = $_POST['email'];
            $password = $_POST['password'];
            //Verifica se le credenziali sono corrette
            $row = UserRepository::userAuthentication($email, $password);
            //Se non sono valide ritorna true
            if ($row == null)
                return true;
            else{
                //Memorizza nelle variabili di sessione lo user id e il
                //displayed_name, ritornati dalla funzione precedente
                $_SESSION['user_id'] = $row['id'];
            }
        }
        //Se non è attiva una sessione ritorna null
        if (!isset($_SESSION['user_id']))
                return false;
        //ritorna session se l'utente è loggato
        return $_SESSION;
    }

    public static function logout(): void
    {
        self::start();
        $_SESSION = [];
        session_destroy();
    }


}