(function () {
    document.addEventListener('DOMContentLoaded', () => {
        updateHideOwnedProductButton();
        updateProductButtons();
        document.querySelectorAll('.product-btn').forEach(btn => {
            btn.addEventListener('click', (event) => {
                const element = event.target;
                const product = element.closest('.product');
                toggleProductOwned(product.id);
                updateProductButtons();
            });
        });
        document.querySelectorAll('.product-hidden-toggle-btn').forEach(btn => {
            btn.addEventListener('click', (event) => {
                toggleHidingOwnedProducts(event.target);
                updateHideOwnedProductButton();
                updateProductButtons();
            });
        });
    });
}());

function toggleProductOwned(product) {
    let ownedProducts = localStorage.getItem('afwoa_owned_products');
    ownedProducts = new Set(ownedProducts ? ownedProducts.split(',') : []);

    if (ownedProducts.has(product)) {
        ownedProducts.delete(product);
    } else {
        ownedProducts.add(product);
    }

    localStorage.setItem('afwoa_owned_products', [...ownedProducts]);
}

function toggleHidingOwnedProducts(btn) {
    btn.classList.toggle('active');
    isActive = btn.classList.contains('active');
    localStorage.setItem('afwoa_hide_owned_products', isActive);
}

function updateHideOwnedProductButton() {
    let hideOwnedProducts = localStorage.getItem('afwoa_hide_owned_products') || 'false';
    document.querySelectorAll('.product-hidden-toggle-btn').forEach(btn => {
        if (hideOwnedProducts === 'true') {
            btn.classList.add('active');
            btn.innerText = 'Show Owned Items';
        } else {
            btn.classList.remove('active');
            btn.innerText = 'Hide Owned Items';
        };
    });
}

function updateProductButtons() {
    const hideOwnedProducts = localStorage.getItem('afwoa_hide_owned_products') || 'false';
    let ownedProducts = localStorage.getItem('afwoa_owned_products');
    ownedProducts = new Set(ownedProducts ? ownedProducts.split(',') : []);

    document.querySelectorAll('.product-btn').forEach(btn => {
        const product = btn.closest('.product');

        if (ownedProducts.has(product.id)) {
            btn.innerText='I need this';
            btn.style.backgroundColor='#DC143C';
            product.style.display = (hideOwnedProducts === 'true') ? 'none' : 'flex';
        } else {
            btn.innerText='I have this';
            btn.style.backgroundColor='#4CAF50';
            product.style.display = 'flex';
        }

    });
};
