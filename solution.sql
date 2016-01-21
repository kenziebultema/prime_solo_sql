--Which authors are represented in our store?
SELECT * FROM authors

Ariel Denham, John Worsley, Paulette Bourgeois, Margery Williams Bianco, Louisa Mar Alcott, Stephen King, Frank Herbert, Burne Hogarth, Margaret Wise Brown, Edgar Allen Poe, Mark Lutz, Tom Christiansen, Richard Brautigan, Poppy Z. Brite, Edward Gorey, Arthur C. Clarke, Andrew Brookins, Neil Simon, Theodor Seuss Geisel


--Which authors are also distinguished authors?
SELECT * distinguished_authors

Neil Simon, Theodor Seuss Geisel


--Which authors are not distinguished authors?
Ariel Denham, John Worsley, Paulette Bourgeois, Margery Williams Bianco, Louisa Mar Alcott, Stephen King, Frank Herbert, Burne Hogarth, Margaret Wise Brown, Edgar Allen Poe, Mark Lutz, Tom Christiansen, Richard Brautigan, Poppy Z. Brite, Edward Gorey, Arthur C. Clarke, Andrew Brookins


--How many authors are represented in our store?
SELECT COUNT(first_name) FROM authors

17


--Who are the favorite authors of the employee with the first name of Michael?
SELECT * FROM favorite_authors
WHERE employee_id = 102

J.R.R. Tolkien, Charles Dickens, Ariel DenRham


--What are the titles of all the books that are in stock today?
SELECT B.title
FROM books B, (SELECT E.book_id
	           FROM editions E, daily_inventory I
	           WHERE E.isbn = I.isbn AND I.is_stocked = 't') D
WHERE B.id = D.book_id

The Cat in the Hat, Dune(x2)


--Insert one of your favorite books into the database. Hint: You’ll want to create data in at least 2 other tables to completely create this book.
INSERT INTO books
    VALUES(1234, 'Genesis', 213, 000);

INSERT INTO authors
    VALUES (213, 'Beckett', 'Bernard')


--What authors have books that are not in stock?
SELECT A.first_name, A.last_name
FROM authors A, (SELECT B.author_id
                 FROM books B, (SELECT E.book_id
	                            FROM editions E, daily_inventory I
	                            WHERE E.isbn = I.isbn AND I.is_stocked = 'f') D
                 WHERE B.id = D.book_id) Z
WHERE A.id = Z.author_id

Stephen King, Arthur C. Clarke, Theodor Seuss Geisel


--What is the title of the book that has the most stock?
SELECT B.title
FROM books B, (SELECT E.book_id
	       FROM editions E, (SELECT isbn, stock
		                 FROM stock
		                 WHERE stock IN (SELECT MAX(stock)
			                         FROM stock)) Z
              WHERE E.isbn = Z.isbn) Y
WHERE B.id = Y.book_id

Dune
