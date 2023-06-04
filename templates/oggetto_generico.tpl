<?php
/**
 * Questo commento serve solo a eliminare l'indicazione di errore
 * @var $oggetto
 * @var $offerente
 * @var $utente
 * @var $canBuy
 * @var $messaggi
 */
?>

<?php

$login = true;
$logout = false;
if($utente != null){
    $login = false;
    $logout = true;
}

$this->layout('home', [
    'titolo' => 'Oggetto',
    'home' => true,
    'oggetti' => $logout,
    'logout' => $logout,
    'vendita' => $logout,
    'comprati' => $logout,
    'login' => $login,
    'search' => true,
    'pagename' => 'index.php',
    'sv' => '',
    'mr' => 'Cerca oggetti in vendita'
]);?>


<?php if ($utente == null): ?>
    <div class="columns">
        <div class="column col-6 col-mx-auto">
            <i>Per contattare il venditore o comprare l'oggetto, devi prima effettuare il <!--suppress HtmlUnknownTarget -->
                <a href="./login.php">login</a>.</i>
            <p>Oggetto venduto da <?php echo $offerente['nome'] ?></p>
        </div>
    </div>
<?php endif; ?>

<div class="columns">
    <div class="column col-6 col-mx-auto">

        <h1><?php echo $oggetto['nome'] ?></h1>
            <?php if ($oggetto['immagine'] != null): ?>
                <img src="<?php echo $oggetto['immagine'] ?>" alt="immagine dell'oggetto" class="img-responsive">
            <?php endif; ?>
        <h3 class="mt-2">Categoria: <?php echo $oggetto['categoria']?></h3>
        <p>L'oggetto è in vendita da <?php echo $oggetto['data_offerta'] ?></p>
    </div>
    <?php if ($utente != null): ?>
    <div class="divider-vert"></div>
    <div class="column">

        <p><?= $utente['nome'] ?>, il tuo saldo è di <?php echo $utente['gettoni'] ?> gettoni</p>
        <?php if ($canBuy): ?>
            <!--suppress HtmlUnknownTarget -->
            <form class="form-horizontal" action="./action.php" method="post">
                <div class="form-group">
                    <div class="col-9 col-sm-12">
                        <label class="form-label" for="input-example-1">Hai abbastanza gettoni per comprare l'oggetto. Ricordati che ti costerà un gettone!</label>
                    </div>
                    <div class="col-3 col-sm-12">
                        <input type="hidden" name="action" value="compra">
                        <input type="hidden" name="id_oggetto" value="<?php echo $oggetto['id'] ?>">
                        <input class="button btn-lg" type="submit" value="Compra!">                    </div>
                </div>
            </form>



            <p>In alternativa, puoi metterti in contatto con il venditore per chiedergli informazioni</p>
            <div class="divider"></div>
            <!--suppress HtmlUnknownTarget -->
            <form action="./action.php" method="post">
                <div class="form-group">
                    <input type="hidden" name="action" value="messaggio">
                    <input type="hidden" name="pagina" value="oggetto.php">
                    <input type="hidden" name="id_oggetto" value="<?php echo $oggetto['id'] ?>">
                    <input type="hidden" name="id_destinatario" value="<?php echo $offerente['id'] ?>">
                    <label class="form-label" for="input-example-1">Manda un messaggio a <?= $offerente['nome'] ?></label>
                    <textarea class="form-input" id="input-example-1" placeholder="Scrivi un messaggio" name="testo" rows="5"></textarea>
                    <button class="btn">Invia!</button>
                </div>
            </form>
        <?php else: ?>
            <p>Non hai abbastanza gettoni per comprare l'oggetto.</p>
            <p>Vendi dei prodotti per acquistarne altri</p>
        <?php endif; ?>
    </div>
    <?php endif; ?>
</div>


<div class="divider mt-4"></div>

<div class="columns">
    <div class="column col-8 col-mx-auto">
    <?php if ($oggetto['descrizione'] != null): ?>
        <?php $righe =   explode("\n", $oggetto['descrizione'] ); ?>
        <h4>Descrizione</h4>
        <?php foreach ($righe as $riga): ?>
            <p><?php echo $riga ?></p>
        <?php endforeach; ?>
    <?php endif; ?>

    <?php if ($utente != null): ?>
        <div class="divider"></div>

        <h5>Messaggi recenti</h5>
        <?php if ($messaggi == null): ?>
            <p>Non ci sono messaggi...</p>
        <?php else: ?>
            <?php foreach ($messaggi as $messaggio): ?>
                <div class="columns">
                    <div class="column col-3">
                        <p><?php echo $messaggio['data'] ?></p>

                    </div>
                    <div class="divider-vert"></div>
                    <div class="column">

                        <?php if ($messaggio['id_mittente'] == $utente['id']): ?>
                            <strong>Tu:</strong>
                        <?php else: ?>
                            <strong><?php echo $offerente['nome'] ?>:</strong>
                        <?php endif; ?>
                        <?php $righe =   explode("\n", $messaggio['testo'] ); ?>
                        <p>
                        <?php foreach ($righe as $riga): ?>
                            <?php echo $riga.'<br/>' ?>
                        <?php endforeach; ?>
                        </p>
                    </div>
                </div>
            <?php endforeach; ?>
        <?php endif; ?>
    <?php endif; ?>
    </div>
</div>


