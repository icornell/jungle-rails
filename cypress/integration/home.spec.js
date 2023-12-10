describe('Home Page', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000')
  })

  it('Should display a part of the welcome paragraph on the home page', () => {
    cy.get('p').should('contain', 'Looking for a way to add some life to your home?')
  })

  it("There are products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There are 12 products on the page", () => {
    cy.get(".products article").should("have.length", 12);
  });

  it("There is a button to add a product to the cart", () => {
    cy.get(".products article button").should("be.visible");
  });

});
