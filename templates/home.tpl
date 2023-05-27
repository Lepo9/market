<?php
/**
 * Questo commento serve solo a eliminare l'indicazione di errore
 * da parte di PHPStorm per la variabile $studenti
 * @var $titolo
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
<div class="divider"></div>
<header class="navbar">
    <section class="navbar-section"></section>


    <?php if($titolo != 'Login'):?>
        <?php if($titolo != 'Market'):?>
            <section class="navbar-center">
                <form action=".">
                    <button class="btn m-2">Back</button>
                </form>
            </section>
        <?php endif;?>

        <?php if($titolo != 'I miei oggetti'):?>
            <section class="navbar-center">
                <form action="." method="get">
                    <input type="hidden" value="my_obg" name="action">
                    <button class="btn m-2">I miei oggetti in vendita</button>
                </form>
            </section>
        <?php endif;?>

        <section class="navbar-center">
            <form action="." method="get">
                <input type="hidden" value="logout" name="action">
                <button class="btn m-2 btn-error">Logout</button>
            </form>
        </section>
    <?php endif;?>
    <section class="navbar-section"></section>
</header>
<div class="container grid-lg">
<!--Questa parte sarà sempre così e serve a includere
il template che contiene il contenuto vero e proprio-->
<?=$this->section('content')?>
</div>
</body>
</html>
