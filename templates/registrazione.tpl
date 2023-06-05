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
    'search' => true,
    'login' => false,
    'pagename' => 'index.php',
    'sv' => '',
    'mr' => 'Cerca oggetti in vendita',
]);?>

<?php if($errore != ''):?>
<div class="toast toast-center z-50">
    <div class="alert alert-error">
        <span><?php echo $errore ?></span>
    </div>
</div>
<?php endif; ?>


<div class="hero">
    <div class="hero-content flex-col lg:flex-row-reverse self-center">
        <div class="flex flex-col text-center">
            <h1 class="text-5xl font-bold m-1">Registrati!</h1>
            <p>In caso di esito positivo, verrai reindirizzato alla pagina di login!</p>
            <p class="pt-4 pb-1">Sei già registrato? <!--suppress HtmlUnknownTarget --></p>
            <!--suppress HtmlUnknownTarget -->
            <a href="./login.php"><button class="btn btn-info">Login</button></a>
        </div>
        <!--suppress HtmlUnknownTarget -->
        <form class="form" action="./action.php" method="post">
            <input type="hidden" name="action" value="registrazione">
            <div class="card flex-shrink-0 w-96 max-w-sm shadow-2xl bg-base-100">
                <div class="card-body">
                    <div class="form-control">
                        <label class="label">
                            <span class="label-text">Nome</span>
                        </label>
                        <!--suppress HtmlFormInputWithoutLabel -->
                        <input type="text" placeholder="nome" class="input input-bordered" name="nome" required/>
                    </div>
                    <div class="form-control">
                        <label class="label">
                            <span class="label-text">Cognome</span>
                        </label>
                        <!--suppress HtmlFormInputWithoutLabel -->
                        <input type="text" placeholder="cognome" class="input input-bordered" name="cognome" required/>
                    </div>

                    <div class="form-control">
                        <label class="label">
                            <span class="label-text">Email</span>
                        </label>
                        <!--suppress HtmlFormInputWithoutLabel -->
                        <input type="email" placeholder="email" class="input input-bordered" name="e-mail" required/>
                    </div>
                    <div class="form-control">
                        <label class="label">
                            <span class="label-text">Password</span>
                        </label>
                        <!--suppress HtmlFormInputWithoutLabel -->
                        <input type="password" placeholder="password" class="input input-bordered" name="password1" required/>
                    </div>
                    <div class="form-control">
                        <label class="label">
                            <span class="label-text">Ripeti la password</span>
                        </label>
                        <!--suppress HtmlFormInputWithoutLabel -->
                        <input type="password" placeholder="password" class="input input-bordered" name="password2" required/>
                    </div>
                    <div class="form-control mt-6">
                        <button class="btn btn-primary">Registrati</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>





