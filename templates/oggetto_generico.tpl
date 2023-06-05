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
            <h1 class="text-3xl font-bold m-8 text-center"><i>Per contattare il venditore o comprare l'oggetto, devi prima effettuare il <!--suppress HtmlUnknownTarget -->
                <a class="btn btn-link btn-lg pb-4" href="./login.php">login</a>.</i>
            </h1>
<?php endif; ?>


<div class="flex w-full justify-center">

    <div class="card w-1/2 bg-base-100 shadow-xl">
        <?php if ($oggetto['immagine'] != null): ?>
            <figure><img src="<?php echo $oggetto['immagine'] ?>" alt="immagine dell'oggetto" /></figure>
        <?php endif; ?>
        <div class="card-body">
            <h1 class="card-title text-3xl font-bold"><?php echo $oggetto['nome'] ?></h1>
            <h3 class="text-2xl"><strong>Categoria:</strong> <?php echo $oggetto['categoria']?></h3>
            <p>L'oggetto è in vendita dal <?php echo $oggetto['data_offerta'] ?></p>
            <p><strong>Venditore:</strong> <?php echo $offerente['nome'] ?></p>
            <div class="divider"></div>
            <?php if ($oggetto['descrizione'] != null): ?>
                <?php $righe =   explode("\n", $oggetto['descrizione'] ); ?>
                <h3 class="text-2xl font-bold">Descrizione</strong></h3>
                <?php foreach ($righe as $riga): ?>
                    <p><?php echo $riga ?></p>
                <?php endforeach; ?>
            <?php endif; ?>

            <?php if ($utente != null): ?>
                <?php if ($canBuy): ?>


                    <!--suppress HtmlUnknownTarget -->
                    <form class="text-center m-6" action="./action.php" method="post">
                        <div class="form-group">

                            <input type="hidden" name="action" value="compra">
                            <input type="hidden" name="id_oggetto" value="<?php echo $oggetto['id'] ?>">
                            <div class="card-actions justify-end">
                                <button class="btn btn-primary">Compra!</button>
                            </div>
                        </div>
                    </form>
            <?php endif; ?>
            <?php endif; ?>

        </div>
    </div>


    <?php if ($utente != null): ?>
    <div class="divider divider-horizontal"></div>
    <div class="flex flex-col">

            <h1 class="text-4xl"><?= $utente['nome'] ?>, il tuo saldo è di <?php echo $utente['gettoni'] ?> gettoni</h1>
            <?php if ($canBuy): ?>
                <h3 class="text-xl">Hai abbastanza gettoni per comprare l'oggetto. Ricordati che <strong>ti costerà un gettone!</strong></h3>
                <!--suppress HtmlUnknownTarget -->
                <form class="text-center m-6" action="./action.php" method="post">
                    <div class="form-group">
                            <input type="hidden" name="action" value="compra">
                            <input type="hidden" name="id_oggetto" value="<?php echo $oggetto['id'] ?>">
                            <button class="btn btn-primary">Compra!</button>
                    </div>
                </form>

                <h3 class="text-xl m-5">In alternativa, puoi metterti in contatto con il venditore per chiedergli informazioni</h3>
                <div class="divider"></div>
        <h5 class="text-lg font-bold">Messaggi recenti</h5>

        <?php if ($messaggi == null): ?>
            <p>Non ci sono messaggi...</p>
        <?php else: ?>
        <?php foreach ($messaggi as $messaggio): ?>

        <?php if ($messaggio['id_mittente'] == $utente['id']): ?>
        <div class="chat chat-end">
            <div class="chat-header">
                Tu
                <?php else: ?>
                <div class="chat chat-start">
                    <div class="chat-header">
                        <?php echo $offerente['nome'] ?>

                        <?php endif; ?>
                        <time class="text-xs opacity-50"><?php echo $messaggio['data'] ?></time>
                    </div>
                    <?php $righe =   explode("\n", $messaggio['testo'] ); ?>
                    <div class="chat-bubble">
                        <?php foreach ($righe as $riga): ?>
                            <?php echo $riga.'<br/>' ?>
                        <?php endforeach; ?>
                    </div>
                </div>

                <?php endforeach; ?>
                <?php endif; ?>

                <div class="divider"></div>

                <!--suppress HtmlUnknownTarget -->
                <form action="./action.php" method="post" class=" text-end">

                        <input type="hidden" name="action" value="messaggio">
                        <input type="hidden" name="pagina" value="oggetto.php">
                        <input type="hidden" name="id_oggetto" value="<?php echo $oggetto['id'] ?>">
                        <input type="hidden" name="id_destinatario" value="<?php echo $offerente['id'] ?>">

                    <div class="form-control">
                        <label class="label">
                            <span class="label-text">Manda un messaggio a <?= $offerente['nome'] ?></span>
                        </label>
                        <!--suppress HtmlFormInputWithoutLabel -->
                        <textarea class="textarea textarea-bordered h-24" placeholder="Scrivi un messaggio" name="testo" rows="5"></textarea>
                    </div>

                        <button class="btn btn-info">Invia!</button>
                </form>
            <?php else: ?>
                <h2 class="text-2xl mt-8">Non hai abbastanza gettoni per comprare l'oggetto.</h2>
                <h3 class="text-xl">Vendi dei prodotti per acquistarne altri.</h3>
                <h3 class="text-xl">Puoi vendere prodotti nella sezione <!--suppress HtmlUnknownTarget -->
                    <a class="btn btn-link" href="./vendita.php">vendi un oggetto</a></h3>
            <?php endif; ?>
            </div>
    <?php endif; ?>


    </div>
</div>




