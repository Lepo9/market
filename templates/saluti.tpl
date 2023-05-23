n<?php
/**
 * Questo commento serve solo a eliminare l'indicazione di errore
 * da parte di PHPStorm per la variabile $studenti
 * @var $nome
 * @var $cognome
 */
?>

<?php $this->layout('home', ['titolo' => 'Saluti']) ?>

<h1>Primo esempio</h1>
<p>Hello, <?= $this->e($nome)?> <?= $this->e($cognome)?></p>
