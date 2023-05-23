<?php
/**
 * Questo commento serve solo a eliminare l'indicazione di errore
 * @var $login_fallito
 */
?>

<?php $this->layout('home', ['titolo' => 'Login']);?>

<h1>Login</h1>
<?php if($login_fallito):?>
    <div class="toast toast-error">
        Credenziali non corrette, riprova.
    </div>
<?php endif; ?>
<form class="form" action="index.php" method="post">
    <div class="form-group">
        <label class="form-label" for="email">Email</label>
        <input class="form-input" type="text" id="email" placeholder="Email" name="email">
    </div>
    <div class="form-group">
        <label class="form-label" for="password">Password</label>
        <input class="form-input" type="password" id="password" placeholder="Password" name="password">
    </div>
    <div class="float-right">
        <input class="btn btn-primary" type="submit" value="Invia credenziali">
    </div>
</form>
