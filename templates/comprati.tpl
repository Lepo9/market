<?php
/**
 * Questo commento serve solo a eliminare l'indicazione di errore
 * @var $oggetti
 * @var $utente
 * @var $ricerca
 * @var $messaggio
 */
?>

<?php $this->layout('home', [
    'titolo' => 'Oggetti che ho comprato',
    'home' => true,
    'oggetti' => true,
    'logout' => true,
    'vendita' => true,
    'comprati' => true,
    'search' => true,
    'pagename' => 'comprati.php',
    'sv' => $ricerca,
    'mr' => 'Cerca tra i comprati',
    'corrente' => 'Oggetti comprati'

]);
?>

<h1 class="text-5xl font-bold text-center">Benvenut* <?php echo $utente['nome'] ?></h1>

<div class="divider"></div>
<h1 class="text-3xl font-bold mb-4 text-center"><?php echo $messaggio ?></h1>

<?php if ($oggetti == null): ?>
    <p>Non hai ancora comprato nessun oggetto...</p>
<?php else: ?>
    <table class="table table-zebra table-lg">
        <thead>
        <tr>
            <th class="text-xl text-center">Nome</th>
            <th class="text-xl text-center">Categoria</th>
            <th class="text-xl text-center">Data dell'acquisto'</th>
            <th class="text-xl text-center">Visualizza</th>
        </tr>
        </thead>
        <tbody>
        <?php foreach ($oggetti as $oggetto): ?>
            <tr>
                <td class="text-center"><?php echo $oggetto['nome'] ?></td>
                <td class="text-center"><?php echo $oggetto['categoria'] ?></td>
                <td class="text-center"><?php echo $oggetto['data_scambio'] ?></td>
                <td class="text-center">
                    <!--suppress HtmlUnknownTarget -->
                    <form method="get" action="./oggetto_scambiato.php">
                        <input type="hidden" name="id_oggetto" value="<?php echo $oggetto['id'] ?>">
                        <label tabindex="0" class="btn btn-ghost btn-square mt-4">
                            <button class="w-10">
                                <!--suppress HtmlUnknownTarget -->
                                <img src="./icons/view_ico.svg" alt=""/>
                            </button>
                        </label>
                    </form>
                </td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
<?php endif; ?>
