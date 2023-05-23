<?php
/**
 * Questo commento serve solo a eliminare l'indicazione di errore
 * da parte di PHPStorm per la variabile $studenti
 * @var $studenti
 */
?>

<?php $this->layout('home', ['titolo' => 'Studenti']) ?>

<h1>Esempio con array</h1>

<h2>Elenco degli studenti sotto forma di elenco puntato</h2>

<ul>
    <?php foreach ($studenti as $studente):?>
        <li><?=$studente['nome']?> <?=$studente['cognome']?></li>
    <?php endforeach;?>
</ul>

<h2>Elenco degli studenti sotto forma di elenco puntato</h2>

<table class="table">
    <thead>
        <tr><th>Nome</th><th>Cognome</th></tr>
    </thead>
    <tbody>
        <?php foreach ($studenti as $studente):?>
            <tr><td><?=$studente['nome']?></td><td><?=$studente['cognome']?></td></tr>
        <?php endforeach;?>
    </tbody>
</table>