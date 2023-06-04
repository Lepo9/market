<?php
/**
 * Questo commento serve solo a eliminare l'indicazione di errore
 * @var $login_fallito
 */
?>

<?php $this->layout('home', [
    'titolo' => 'Login',
    'home' => false,
    'oggetti' => false,
    'logout' => false,
    'vendita' => false,
    'comprati' => false,
    'search' => false,
]);?>

<h1>Login</h1>
<h3><i>oppure <a href="./registrazione.php">registrati</a></i></h3>
<?php if($login_fallito):?>
    <div class="toast toast-error">
        Credenziali non corrette, riprova.
    </div>
<?php endif; ?>
<form class="form" action="index.php" method="post">
    <div class="form-group">
        <label class="form-label" for="email">Email</label>
        <input class="form-input" type="text" id="email" placeholder="Email" name="email" required>
    </div>
    <div class="form-group">
        <label class="form-label" for="password">Password</label>
        <input class="form-input" type="password" id="password" placeholder="Password" name="password" required>
    </div>
    <div class="float-right">
        <input class="btn btn-primary" type="submit" value="Login">
    </div>
</form>
