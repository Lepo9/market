<?php
/**
 * Questo commento serve solo a eliminare l'indicazione di errore
 * da parte di PHPStorm per la variabile $studenti
 * @var $titolo
 * @var $home
 * @var $oggetti
 * @var $logout
 * @var $vendita
 * @var $comprati
 * @var $search
 * @var $pagename
 * @var $sv
 * @var $mr
 * @var $login
 * @var $corrente
 */

if (!isset($login)) $login = false;

?>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <!--suppress JSUnresolvedLibraryURL -->
    <link href="https://cdn.jsdelivr.net/npm/daisyui@3.0.3/dist/full.css" rel="stylesheet" type="text/css" />
    <script src="https://cdn.tailwindcss.com"></script>
    <title><?=$this->e($titolo)?></title>
</head>
<body class="">

<div class="navbar bg-neutral mb-8 sticky top-0 z-50">
    <div class="navbar-start">
    </div>
    <div class="navbar-center">
        <div class="tabs tabs-boxed">
        <?php if($home):?>
                <a href="." class="tab tab-lg tab-lifted <?php if($corrente == 'Home') echo 'tab-active'?>">Home</a>
        <?php endif;?>

        <?php if($oggetti):?>
                <!--suppress HtmlUnknownTarget -->
                <a href="./miei_oggetti.php" class="tab tab-lg tab-lifted <?php if($corrente == 'I miei oggetti in vendita') echo 'tab-active'?>">I miei oggetti in vendita</a>
        <?php endif;?>

        <?php if($vendita):?>
                <!--suppress HtmlUnknownTarget -->
                <a href="./vendita.php" class="tab tab-lg tab-lifted <?php if($corrente == 'Vendi un oggetto') echo 'tab-active'?>">Vendi un oggetto</a>
        <?php endif;?>

        <?php if($comprati):?>
                <!--suppress HtmlUnknownTarget -->
                <a href="./comprati.php" class="tab tab-lg tab-lifted <?php if($corrente == 'Oggetti comprati') echo 'tab-active'?>">Oggetti comprati</a>
        <?php endif;?>
        </div>
    </div>
    <div class="navbar-end">
        <?php if($search):?>
        <form method="get" action="./<?=$pagename?>" class="mt-4">
            <div class="join">
                <!--suppress HtmlFormInputWithoutLabel -->
                <input class="input join-item" type="text" name="search" placeholder="<?= $mr?>" value="<?= $sv ?>"/>
                <button class="btn btn-primary join-item">Search</button>

            </div>
        </form>
        <?php endif;?>

        <?php if($logout):?>
                <a href="./?action=logout"><button class="btn btn-error m-3">Logout</button></a>
        <?php endif;?>

        <?php if($login):?>
                <!--suppress HtmlUnknownTarget -->
                <a href="./login.php"><button class="btn m-2">Login</button></a>
        <?php endif;?>

    </div>
</div>


<main class="grid justify-center mb-8 mx-8">
<!--Questa parte sarà sempre così e serve a includere
il template che contiene il contenuto vero e proprio-->
<?=$this->section('content')?>
</main>
</body>
</html>
