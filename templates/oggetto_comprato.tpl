<?php
/**
 * Questo commento serve solo a eliminare l'indicazione di errore
 * @var $oggetto
 * @var $offerente
 * @var $utente
 * @var $messaggi
 */
?>

<?php $this->layout('home', [
    'titolo' => 'Oggetto comprato',
    'home' => true,
    'oggetti' => true,
    'logout' => true,
    'vendita' => true,
    'comprati' => true,
    'search' => true,
    'pagename' => 'comprati.php',
    'sv' => '',
    'mr' => 'Cerca tra i comprati'
]);?>



<div class="flex w-full justify-center">

    <div class="card w-1/2 bg-base-100 shadow-xl">
        <?php if ($oggetto['immagine'] != null): ?>
            <figure><img src="<?php echo $oggetto['immagine'] ?>" alt="immagine dell'oggetto" /></figure>
        <?php endif; ?>
        <div class="card-body">
            <h1 class="card-title text-3xl font-bold"><?php echo $oggetto['nome'] ?></h1>
            <h3 class="text-2xl"><strong>Categoria:</strong> <?php echo $oggetto['categoria']?></h3>
            <p>L'oggetto era stato messo in vendita il <?php echo $oggetto['data_offerta'] ?></p>
            <p>L'acquisto è avvenuto il <?php echo $oggetto['data_scambio'] ?></p>
            <p><strong>Venditore:</strong> <?php echo $offerente['nome'] ?></p>
            <div class="divider"></div>
            <?php if ($oggetto['descrizione'] != null): ?>
                <?php $righe =   explode("\n", $oggetto['descrizione'] ); ?>
                <h3 class="text-2xl font-bold">Descrizione</strong></h3>
                <?php foreach ($righe as $riga): ?>
                    <p><?php echo $riga ?></p>
                <?php endforeach; ?>
            <?php endif; ?>

        </div>
    </div>


    <div class="divider divider-horizontal "></div>


    <div class="flex flex-col max-w-lg min-w-min">



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

            </div>


        </div>
    </div>




