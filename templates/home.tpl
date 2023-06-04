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
 */
?>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://unpkg.com/spectre.css/dist/spectre.min.css">
    <link rel="stylesheet" href="https://unpkg.com/spectre.css/dist/spectre-exp.min.css">
    <link rel="stylesheet" href="https://unpkg.com/spectre.css/dist/spectre-icons.min.css">
    <title><?=$this->e($titolo)?></title>
</head>
<body>
<header class="navbar">
    <section class="navbar-section"></section>


        <?php if($home):?>
            <section class="navbar-center">
                <a href="."><button class="btn m-2">Home</button></a>
            </section>
        <?php endif;?>

        <?php if($oggetti):?>
            <section class="navbar-center">
                    <a href="./miei_oggetti.php"><button class="btn m-2">I miei oggetti in vendita</button></a>
            </section>
        <?php endif;?>

        <?php if($vendita):?>
        <section class="navbar-center">
            <a href="./vendita.php"><button class="btn m-2">Vendi un oggetto</button></a>
        </section>
        <?php endif;?>

        <?php if($comprati):?>
            <section class="navbar-center">
                <a href="./comprati.php"><button class="btn m-2">Oggetti comprati</button></a>
            </section>
        <?php endif;?>

        <?php if($search):?>
            <section class="navbar-center mt-2">
                <form method="get" action="./<?=$pagename?>" class="mt-2">
                    <div class="input-group input-inline">
                        <input class="form-input input" type="text" name="search" placeholder="<?= $mr?>" value="<?= $sv ?>">
                        <button class="btn btn-primary btn input-group-btn">Search</button>
                    </div>
                </form>
            </section>
        <?php endif;?>

        <?php if($logout):?>
            <section class="navbar-center">
                <a href="./?action=logout"><button class="btn m-2 btn-error">Logout</button></a>
            </section>
        <?php endif;?>

        <?php if($login):?>
            <section class="navbar-center">
                <a href="./login.php"><button class="btn m-2">Login</button></a>
            </section>
        <?php endif;?>



    <section class="navbar-section"></section>
</header>


<div class="divider"></div>

<div class="container grid-lg">
<!--Questa parte sarà sempre così e serve a includere
il template che contiene il contenuto vero e proprio-->
<?=$this->section('content')?>
</div>
</body>
</html>
