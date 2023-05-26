<?php
/**
 * Questo commento serve solo a eliminare l'indicazione di errore
 * @var $oggetto
 * @var $offerente
 * @var $utente
 * @var $canBuy
 */
?>

<?php $this->layout('home', ['titolo' => 'Chat']);?>
<h1><?php echo $oggetto['nome'] ?></h1>
<?php if ($oggetto['immagine'] != null): ?>
    <img src="<?php echo $oggetto['immagine'] ?>" alt="immagine dell'oggetto">
<?php endif; ?>
<h3>Categoria: <?php echo $oggetto['categoria']?></h3>
<p>L'oggetto è in vendita da <?php echo $oggetto['data_offerta'] ?></p>
<?php if ($oggetto['descrizione'] != null): ?>
    <p><?php echo $oggetto['descrizione']?></p>
<?php endif; ?>

<div class="divider"></div>

<p>Il tuo saldo è di <?php echo $utente['gettoni'] ?> gettoni</p>

<?php if ($canBuy): ?>
<form action="." method="post">
    <p>Hai abbastanza gettoni per comprare l'oggetto. Ricordati che ti costerà un gettone!</p>
    <input type="hidden" name="action" value="compra">
    <input type="hidden" name="id_oggetto" value="<?php echo $oggetto['id'] ?>">
    <input type="hidden" name="id_offerente" value="<?php echo $offerente['id'] ?>">
    <input class="button" type="submit" value="Compra!">
</form>
<p>In alternativa, puoi metterti in contatto con il venditore per chiedergli informazioni</p>
<div class="divider"></div>
<form action="." method="get">
    <div class="form-group">
        <input type="hidden" name="action" value="messaggio">
        <input type="hidden" name="id_oggetto" value="<?php echo $oggetto['id'] ?>">
        <input type="hidden" name="id_destinatario" value="<?php echo $offerente['id'] ?>">
        <label class="form-label" for="input-example-1">Manda un mesaggio a <?= $offerente['nome'] ?></label>
        <input class="form-input" type="text-area" id="input-example-1" placeholder="Scrivi un messaggio" name="msg">
        <button class="btn">Invia!</button>
    </div>
</form>
<?php else: ?>
<p>Non hai abbastanza gettoni per comprare l'oggetto.</p>
<p>Vendi dei prodotti per acquistarne altri</p>
<?php endif; ?>

<p>Messaggi recenti</p>



