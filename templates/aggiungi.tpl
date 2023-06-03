<?php
/**
 * Questo commento serve solo a eliminare l'indicazione di errore
 * @var $oggetti_disponibili
 * @var $categorie
 * @var $messaggio
 * @var $nome
 * @var $descrizione
 * @var $errore
 */
?>

<?php $this->layout('home', [
    'titolo' => 'Aggiungi oggetto',
    'home' => true,
    'oggetti' => true,
    'logout' => true,
    'vendita' => false,
    'comprati' => true
]);?>

<h1>Aggiungi un oggetto</h1>

<?php if ($errore != ""): ?>
    <div class="toast toast-error">
        <?php echo $errore ?>
    </div>
<?php endif; ?>
<?php if ($messaggio != ""): ?>
    <div class="toast toast-success">
        <?php echo $messaggio ?>
    </div>
<?php endif;?>



<form action="./vendita.php" method="post" enctype="multipart/form-data">
<div class="form-group">
    <label class="form-label" for="input-example-1">Nome</label>
    <input class="form-input" type="text" id="input-example-1" placeholder="Inserisci il nome del prodotto" name="nome" required value="<?= $nome ?>">
</div>
<div class="form-group">
    <label class="form-label" for="input-example-2">Descrizione</label>
    <textarea class="form-input" id="input-example-2" placeholder="Inserisci la descrizione del prodotto" rows="5" name="descrizione"><?= htmlentities($descrizione) ?></textarea>
</div>
<div class="form-group">
    <label class="form-label" for="input-example-3">Immagine</label>
    <input class="form-input" type="file" id="input-example-3" placeholder="Name" name="immagine" accept="image/*">
</div>
<div class="form-group">
    <label class="form-label" for="input-example-4">Categoria</label>
    <select id="input-example-4" class="form-select" name="categoria">
        <option value="0">Seleziona una categoria</option>
        <?php foreach ($categorie as $categoria): ?>
            <option value="<?php echo $categoria['id'] ?>"><?php echo $categoria['descrizione'] ?></option>
        <?php endforeach; ?>
    </select>
</div>
<div class="form-group">
    <input class="btn" type="submit" value="Carica l'oggetto!">
</div>
</form>

