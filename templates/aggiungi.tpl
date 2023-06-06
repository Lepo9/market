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
    'vendita' => true,
    'comprati' => true,
    'search' => true,

    'pagename' => 'index.php',
    'sv' => "",
    'mr' => 'Cerca oggetti in vendita',
    'corrente' => 'Vendi un oggetto'

]);

?>



<?php if ($errore != ""): ?>

    <div class="toast toast-center z-50">
        <div class="alert alert-error">
            <span><?php echo $errore ?></span>
        </div>
    </div>
<?php endif; ?>
<?php if ($messaggio != ""): ?>

    <div class="toast toast-center z-50">
        <div class="alert alert-success">
            <span><?php echo $messaggio ?></span>
        </div>
    </div>
<?php endif;?>



<div class="hero">
    <div class="hero-content flex-col lg:flex-row-reverse self-center">
        <div class="flex flex-col text-center">
            <h1 class="text-5xl font-bold m-1">Aggiungi un oggetto!</h1>
        </div>
        <!--suppress HtmlUnknownTarget -->
        <form action="./vendita.php" method="post" enctype="multipart/form-data">
            <?php if(isset($id_oggetto)): ?>
                <input type="hidden" name="id_oggetto_vecchio" value="<?= $id_oggetto ?>">
            <?php endif; ?>
            <div class="card flex-shrink-0 w-96 max-w-sm shadow-2xl bg-base-100">
                <div class="card-body">
                    <div class="form-control">
                        <label class="label">
                            <span class="label-text">Nome</span>
                        </label>
                        <!--suppress HtmlFormInputWithoutLabel -->
                        <input type="text" placeholder="Inserisci il nome del prodotto" class="input input-bordered" name="nome" value="<?= $nome ?>" required/>
                    </div>
                    <div class="form-control">
                        <label class="label">
                            <span class="label-text">Descrizione</span>
                        </label>
                        <!--suppress HtmlFormInputWithoutLabel -->
                        <textarea class="textarea textarea-bordered" placeholder="Inserisci la descrizione del prodotto" rows="5" name="descrizione"><?= htmlentities($descrizione) ?></textarea>
                    </div>

                    <div class="form-control">
                        <label class="label">
                            <span class="label-text">Immagine</span>
                        </label>
                        <!--suppress HtmlFormInputWithoutLabel -->
                        <input class="file-input file-input-bordered" type="file" placeholder="immagine" name="immagine" accept="image/*">
                    </div>
                    <div class="form-control">
                        <label class="label">
                            <span class="label-text">Categoria</span>
                        </label>
                        <!--suppress HtmlFormInputWithoutLabel -->
                        <select  class="select select-bordered w-full max-w-xs" name="categoria">

                        <?php if(isset($id_categoria)): ?>
                                <?php foreach ($categorie as $categoria): ?>
                                    <option value="<?php echo $categoria['id'] ?>" <?php if($categoria['id'] == $id_categoria) echo "selected";?>><?php echo $categoria['descrizione'] ?></option>
                                <?php endforeach; ?>
                        <?php else: ?>
                                <option value="0" disabled selected>Seleziona una categoria</option>
                                <?php foreach ($categorie as $categoria): ?>
                                    <option value="<?php echo $categoria['id'] ?>"><?php echo $categoria['descrizione'] ?></option>
                                <?php endforeach; ?>

                        <?php endif; ?>
                        </select>
                    </div>



                    <div class="form-control mt-6">
                        <button class="btn btn-accent">Carica l'oggetto!</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
