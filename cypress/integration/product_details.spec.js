describe('Product Details Page', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000');
    cy.get(".products article")
      .should("be.visible")
      .should("have.length", 12);
  });
  it('Should display a product details page when a product is clicked', () => {
    cy.get(".products article").first().click();
    cy.get(".product-detail").should("be.visible");
  });
  it('Should display the product name on the product details page', () => {
    cy.get(".products article").first().click();
    cy.get(".product-detail h1").should("be.visible");
  });
  it('Should show a button to add the product to the cart on the product details page', () => {
    cy.get(".products article").first().click();
    cy.get(".product-detail button").should("be.visible");
  });
  it('Should add a product to the cart when the add to cart button is clicked', () => {
    cy.get(".products article").first().click();
    cy.get(".product-detail button").click();
    cy.get(".navbar .nav-item .nav-link").should("contain", "1");
  });

  it('Should show that the item is sold out if the quantity is 0', () => {
    cy.get(".products article").last().click();
    cy.get(".product-detail .btn-danger").should("be.visible");
  });
  
  it('Should return to the home page when the logo button is clicked', () => {
    cy.get(".products article").first().click();
    cy.get(".navbar-brand").click();
    cy.get(".products article").should("be.visible");
  });

  it('Should go to the cart page when the cart button is clicked', () => {
    cy.get(".products article").first().click();
    cy.get(".end-0 > .nav-link").click(); 
    cy.url().should('include', '/cart');
  });

});
