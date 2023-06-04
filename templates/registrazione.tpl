<?php
/**
 * Questo commento serve solo a eliminare l'indicazione di errore
 * @var $login_fallito
 * @var $errore
 */
?>

<?php $this->layout('home', [
    'titolo' => 'Login',
    'home' => true,
    'oggetti' => false,
    'logout' => false,
    'vendita' => false,
    'comprati' => false,
    'search' => false,
    'login' => false
]);?>


<?php if($errore != ''):?>
    <div class="toast toast-error">
        <?php echo $errore ?>
    </div>
<?php endif; ?>

<h1>Registrazione</h1>
<h3>Inserisci i tuoi dati</h3>

<form class="form" action="./action.php" method="post">
    <input type="hidden" name="action" value="registrazione">
    <div class="form-group">
        <label class="form-label" for="nome">Nome</label>
        <input class="form-input" type="text" id="nome" placeholder="Nome" name="nome" required>
    </div>
    <div class="form-group">
        <label class="form-label" for="cognome">Cognome</label>
        <input class="form-input" type="text" id="cognome" placeholder="Cognome" name="cognome" required>
    </div>
    <div class="form-group">
        <label class="form-label" for="email">Email</label>
        <input class="form-input" type="text" id="email" placeholder="Email" name="e-mail" required>
    </div>
    <div class="form-group">
        <label class="form-label" for="password1">Password</label>
        <input class="form-input" type="password" id="password1" placeholder="Password" name="password1" required>
    </div>
    <div class="form-group">
        <label class="form-label" for="password2">Ripeti la password</label>
        <input class="form-input" type="password" id="password2" placeholder="Password" name="password2" required>
    </div>
    <div class="float-right">
        <input class="btn btn-primary" type="submit" value="Registrati">
    </div>
</form>

<p>In caso di esito positivo, verrai reinderizzato alla pagina di login!</p>

<h5>Sei già registrato?</h5>
<p><i>fai il <a href="./index.php">login</a></i></p>
