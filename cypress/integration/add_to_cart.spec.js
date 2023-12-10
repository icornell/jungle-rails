describe('Add to Cart Feature', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000');
  });
    it ('Should display a add to cart button', () => {
      cy.get('button')
        .contains('Add')
        .should('be.visible');
    });

    it("Should add an item to the cart when button is clicked", () => {
      cy.get('nav')
        .contains('My Cart (0)');

      cy.get('button')
        .contains('Add')
        .click({ force: true });
  
      cy.get('nav')
        .contains('My Cart (1)');
    });

    it('Should show that the item is sold out if the quantity is 0 and not let the add button be clicked', () => {
      cy.get('.products article')
        .last()
        .contains('Sold Out')
        .should('be.visible')

      cy.get('button')
        .last()
        .contains('Add')
        .should('be.disabled');
    });
    
    it('Should go to the cart page when the cart button is clicked', () => {
      cy.get('button')
        .contains('Add')
        .click({ force: true });

      cy.get('nav')
        .contains('My Cart (1)')
        .click();

      cy.url().should('include', '/cart');
     });

});
