<?php
/**
 * Questo commento serve solo a eliminare l'indicazione di errore
 * @var $login_fallito
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
    'corrente' => '',
    'pagename' => 'index.php',
    'sv' => '',
    'mr' => 'Cerca oggetti in vendita',
]);?>


<?php if($login_fallito):?>
    <div class="toast toast-center">
        <div class="alert alert-error">
            <span>Credenziali non corrette, riprova.</span>
        </div>
    </div>

<?php endif; ?>

<div class="hero">

    <div class="hero-content flex-col lg:flex-row-reverse self-center">
        <div class="flex flex-col text-center">
            <h1 class="text-5xl font-bold">Accedi!</h1>
            <p class="py-6">Non hai un account? <!--suppress HtmlUnknownTarget --></p>
            <!--suppress HtmlUnknownTarget -->
            <a href="./registrazione.php"><button class="btn btn-info">registrati</button></a>
        </div>
        <!--suppress HtmlUnknownTarget -->
        <form class="form" action="./login.php" method="post">
            <div class="card flex-shrink-0 w-96 max-w-sm shadow-2xl bg-base-100">
                <div class="card-body">
                    <div class="form-control">
                        <label class="label">
                            <span class="label-text">Email</span>
                        </label>
                        <!--suppress HtmlFormInputWithoutLabel -->
                        <input type="email" placeholder="email" class="input input-bordered" name="email" required/>
                    </div>
                    <div class="form-control">
                        <label class="label">
                            <span class="label-text">Password</span>
                        </label>
                        <!--suppress HtmlFormInputWithoutLabel -->
                        <input type="password" placeholder="password" class="input input-bordered" name="password" required/>
                    </div>
                    <div class="form-control mt-6">
                        <button class="btn btn-accent">Login</button>
                    </div>



                </div>
            </div>
        </form>
    </div>
</div>