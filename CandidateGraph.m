%This script puts together the data for the Nobel candidates.
%
%First version: 21 February 2018, Richard S.J. Tol
%This version: 21 March 2025, Richard S.J. Tol

%% 
s1 = {'Philippe Aghion (2025)' 'Philippe Aghion (2025)' 'Yves Balasko' 'Jerry Green'};
p1 = {'Yves Balasko' 'Jerry Green' 'Jean-Pierre Aubin' 'Lionel McKenzie'};

s3 = {'Jean-Pierre Aubin' 'Jean-Pierre Aubin' 'Jacques-Louis Lions' 'Laurent Schwartz' 'Georges Valiron' 'Emile Borel' 'Gaston Darboux' 'Gaston Darboux'};
p3 = {'Jacques-Louis Lions' 'Jean-Pierre Kahane' 'Laurent Schwartz' 'Georges Valiron' 'Emile Borel' 'Gaston Darboux' 'Michel Chasles' 'Joseph Bertrand'};

s4 = {'Jean-Pierre Kahane' 'Szolem Mandelbrojt' 'Szolem Mandelbrojt' 'Szolem Mandelbrojt' 'Emile Picard' 'Jules Tannery' 'Charles Hermite' 'Eugene-Charles Catalan' 'Joseph Louiville'};
p4 = {'Szolem Mandelbrojt' 'Jacques Hadamard' 'Jules Tannery' 'Emile Picard' 'Gaston Darboux' 'Charles Hermite' 'Eugene-Charles Catalan' 'Joseph Louiville' 'Simeon-Denis Poisson'};

s = [s1 s3 s4];
p = [p1 p3 p4];

C1 = addedge(G56,p,s);

% Leontief: Jorgenson
s = {'Dale Jorgenson'};
p = {'Wassily Leontief (1973)'};

C1 = addedge(C1,p,s);

s0 = {'Richard Blundell' 'John Moore' 'Stephen Bond'};
p0 = {'W.M. Gorman' 'Stephen Nickell' 'Stephen Nickell'};

s1 = {'Martin Feldstein' 'W.M. Gorman' 'George Duncan' 'Charles Bastable' 'Charles Bastable' 'Stephen Nickell' 'Stephen Nickell'};
p1 = {'W.M. Gorman' 'George Duncan' 'Charles Bastable' 'J.W. Stubbs' 'J.P. Mahaffy' 'W.M. Gorman' 'Frank Hahn'};

s2 = {'Richard Freeman' 'John Dunlop'};
p2 = {'John Dunlop' 'John Maynard Keynes'};

s3 = {'Lawrence Summers' 'Lawrence Summers' 'Benjamin Friedman' 'Benjamin Friedman'};
p3 = {'Benjamin Friedman' 'Martin Feldstein' 'Dale Jorgenson' 'Martin Feldstein'};

s = [s0 s1 s2 s3];
p = [p0 p1 p2 p3];

C1 = addedge(C1,p,s);

s0 = {'Edward Lazear' 'Edward Lazear'};
p0 = {'Zvi Griliches' 'Sherwin Rosen'};

s1 = {'Stephen Berry' 'Ariel Pakes' 'Matthew Gentzkow' 'Emi Nakamura' 'Emi Nakamura'};
p1 = {'Ariel Pakes' 'Zvi Griliches' 'Ariel Pakes' 'Ariel Pakes' 'Robert Barro'};

s = [s0 s1];
p = [p0 p1];

C1 = addedge(C1,p,s);

s = {'Kevin Murphy'};
p = {'Sherwin Rosen'};

C1 = addedge(C1,p,s);

s0 = {'Jagdish Bhagwati' 'Gene Grossman' 'Marc Melitz' 'Marc Melitz'};
p0 = {'Charles Kindleberger' 'Jagdish Bhagwati' 'James Levinsohn' 'Susanto Basu'};

s1 = {'James Levinsohn' 'James Levinsohn' 'Avinash Dixit' 'Avinash Dixit' 'Susanto Basu' 'Gregory Mankiw' 'Gregory Mankiw' 'Ricardo Caballero' 'Ricardo Caballero'};
p1 = {'Gene Grossman' 'Avinash Dixit' 'Robert Solow (1987)' 'Morris Adelman' 'Gregory Mankiw' 'Olivier Blanchard' 'Stanley Fischer' 'Olivier Blanchard' 'Stanley Fischer'};

s = [s0 s1];
p = [p0 p1];

C1 = addedge(C1,p,s);

s = {'Olivier Blanchard' 'Olivier Blanchard' 'Jordi Gali' 'Nobuhiro Kiyotaki' 'Robert Hall'};
p = {'Stanley Fischer' 'Robert Solow (1987)' 'Olivier Blanchard' 'Olivier Blanchard' 'Robert Solow (1987)'};

C1 = addedge(C1,p,s);

s = {'Harold Demsetz' 'Sam Peltzman' 'Sam Peltzman' 'Sam Peltzman' 'Lester Telser'};
p = {'Frank Knight' 'George Stigler (1982)' 'Milton Friedman (1976)' 'Lester Telser' 'Milton Friedman (1976)'};

C1 = addedge(C1,p,s);

s = {'Armin Falk' 'Ernst Fehr' 'Ernst Fehr' 'Alexander van der Bellen' 'Clemens-August Andreae' 'Guenther Smoelders' 'Guenther Smoelders' 'Guenther Smoelders' 'Heinrich Herkner'};
p = {'Ernst Fehr' 'Gerhard Orosol' 'Alexander van der Bellen' 'Clemens-August Andreae' 'Guenther Smoelders' 'Herbert von Beckerath' 'Ludwig Bernhard' 'Heinrich Herkner' 'Ludwig Brentano'};

C1 = addedge(C1,p,s);

s = {'Kenneth French' 'William Schwert'};
p = {'William Schwert' 'Eugene Fama (2013)'};

C1 = addedge(C1,p,s);

s = {'Jerry Hausman' 'Jerry Hausman'};
p = {'James Mirrlees (1996)' 'John Flemming'};

C1 = addedge(C1,p,s);

s = {'Elhanan Helpman'};
p = {'Hendrik Houthakker'};

C1 = addedge(C1,p,s);

s = {'David Hendry' 'Peter Phillips' 'Pierre Perron' 'Manuel Arellano'};
p = {'Denis Sargan' 'Denis Sargan' 'Peter Phillips' 'Denis Sargan'};

C1 = addedge(C1,p,s);

s0 = {'Peter Howitt (2025)' 'John Ledyard' 'Stanley Reiter' 'Stanley Reiter'};
p0 = {'John Ledyard' 'Stanley Reiter' 'Tjalling Koopmans (1975)' 'Leonid Hurwicz (2007)'};

s1 = {'Brian Arthur' 'Brian Arthur' 'Stuart Dreyfus' 'Arthur Bryson' 'Hans Liepmann' 'Hans Liepmann'};
p1 = {'Daniel McFadden (2000)' 'Stuart Dreyfus' 'Arthur Bryson' 'Hans Liepmann' 'Richard Bar' 'Theodore von Karman'};

s2 = {'Richard Bar' 'Richard Bar' 'Georg Rost' 'Emil Hilb' 'Friedrich Prym'  'Friedrich Prym'  'Martin Ohm' 'Karl von Langsdorf'};
p2 = {'Georg Rost' 'Emil Hilb' 'Friedrich Prym' 'Ferdinand Lindemann' 'Ernst Kummer' 'Martin Ohm' 'Karl von Langsdorf' 'Abraham Kaestner'};

s = [s0 s1 s2];
p = [p0 p1 p2];

C1 = addedge(C1,p,s);

s = {'Michael Jensen'};
p = {'Merton Miller (1990)'};

C1 = addedge(C1,p,s);

s0 = {'Mark Granovetter' 'Harrison White' 'Harrison White' 'John Slater' 'John Slater' 'Marion Levy'};
p0 = {'Harrison White' 'John Slater' 'Marion Levy' 'Niels Bohr' 'Percy Bridgman' 'Talcott Parsons'};

s1 = {'Karl Hasse' 'Ernst Weber' 'Ernst Weber' 'Ernst Weber' 'Ernst Weber' 'Ernst Chladni' 'Hermann von Helmholtz'};
p1 = {'Ernst Weber' 'Ernst Chladni' 'Ludwig Gilbert' 'Johann Rosenmueller' 'Johann Clarus' 'Georg Lichtenberg' 'Johannes Mueller'};

s2 = {'Johannes Mueller' 'Karl Meyer' 'Karl Meyer' 'Carl Kielmeyer' 'Carl Kielmeyer' 'Carl Kielmeyer' 'Carl Kielmeyer' 'Carl Kielmeyer'};
p2 = {'Karl Meyer' 'Wilhelm Ploucquet' 'Carl Kielmeyer' 'Carl Koestlin' 'Christian Reuss' 'Johann Blumenbach' 'Johann Gmelin' 'Georg Lichtenberg'};

s = [s0 s1 s2];
p = [p0 p1 p2];

C1 = addedge(C1,p,s);

s = {'Israel Kirzner'};
p = {'Ludwig von Mises'};

C1 = addedge(C1,p,s);

s = {'Anne Krueger' 'James Earley' 'Walter Morton' 'Walter Morton' 'William Scott'};
p = {'James Earley' 'Walter Morton' 'John Commons' 'William Scott' 'Richard Ely'};

C1 = addedge(C1,p,s);

s0 = {'John List' 'Shelby Gerking' 'Saul Pleeter' 'Saul Pleeter' 'Cliff Lloyd'};
p0 = {'Shelby Gerking' 'Saul Pleeter' 'Cliff Lloyd' 'James Holmes' 'John Hicks (1972)'};

s1 = {'James Holmes' 'Harry Johnson' 'Harry Johnson'};
p1 = {'Harry Johnson' 'John Maynard Keynes' 'Gottfried Haberler'};

s = [s0 s1];
p = [p0 p1];

C1 = addedge(C1,p,s);

s = {'Charles Manski'};
p = {'Franklin Fisher'};

C1 = addedge(C1,p,s);

s0 = {'Ran Spiegler' 'Ariel Rubinstein' 'Menahem Yaari' 'Menahem Yaari' 'Herbert Scarf'};
p0 = {'Ariel Rubinstein' 'Menahem Yaari' 'Kenneth Arrow (1972)' 'Herbert Scarf' 'Salomon Bochner'};

s1 = {'Salomon Bochner' 'Erhard Schmidt' 'Salomon Bochner' 'Issai Schur' 'Issai Schur'};
p1 = {'Erhard Schmidt' 'David Hilbert' 'Issai Schur' 'Ferdinand Frobenius' 'Lazarus Fuchs'};

s2 = {'Ferdinand Frobenius' 'Ferdinand Frobenius' 'Lazarus Fuchs' 'Lazarus Fuchs'};
p2 = {'Ernst Kummer' 'Karl Weierstrass' 'Ernst Kummer' 'Karl Weierstrass'};

s3 = {'Karl Weierstrass' 'Karl Weierstrass' 'Christoph Gudermann' 'Christoph Gudermann'};
p3 = {'Friedrich Richelot' 'Christoph Gudermann' 'Carl Gauss' 'Bernard Thibaut'};

s = [s0 s1 s2 s3];
p = [p0 p1 p2 p3];

C1 = addedge(C1,p,s);

s = {'Raghuram Rajan' 'Stewart Myers' 'Alexander Robichek'};
p = {'Stewart Myers' 'Alexander Robichek' 'David Alhadeff'};

C1 = addedge(C1,p,s);

s = {'Hashem Pesaran' 'Piero Sraffa' 'Piero Sraffa' 'Luigi Pasinetti' 'Luigi Pasinetti'};
p = {'David Champernowne' 'Luigi Einaudi' 'John Maynard Keynes' 'Richard Kahn' 'Piero Sraffa'};

C1 = addedge(C1,p,s);

s = {'Matthew Rabin' 'Drew Fudenberg'};
p = {'Drew Fudenberg' 'Eric Maskin (2007)'};

C1 = addedge(C1,p,s);

s0 = {'Colin Camerer' 'Colin Camerer' 'Robin Hogarth' 'Hillel Einhorn' 'Alan Bass' 'Alan Bass'};
p0 = {'Robin Hogarth' 'Hillel Einhorn' 'Hillel Einhorn' 'Alan Bass' 'Ledyard Tucker' 'Harry Triandis'};

s1 = {'Ledyard Tucker' 'Ledyard Tucker' 'Ledyard Tucker'};
p1 = {'Thomas Edison' 'Walter Bingham' 'James R. Angell'};

s3 = {'Walter Bingham' 'Edward Thorndike' 'Edward Thorndike'};
p3 = {'Edward Thorndike' 'William James' 'James Cattell'};

s4 = {'James Cattell' 'James Cattell' 'James Cattell' 'James Cattell'};
p4 = {'Rudolf Lotze' 'Granville Hall' 'Wilhelm Wundt' 'Francis Galton'};

s5 = {'Wilhelm Wundt' 'Wilhelm Wundt' 'Wilhelm Wundt'};
p5 = {'Karl Hasse' 'Johannes Mueller' 'Hermann von Helmholtz'};

s9 = {'Rudolf Lotze' 'Rudolf Lotze' 'Rudolf Lotze' 'Rudolf Lotze'};
p9 = {'Ernst Weber' 'William Drobisch' 'Christian Weisse' 'Johann Clarus'};

s10 = {'Harry Triandis' 'William Lambert' 'Richard Solomon' 'Joseph Hunt' 'Madison Bentley' 'Edward Titchener'};
p10 = {'William Lambert' 'Richard Solomon' 'Joseph Hunt' 'Madison Bentley' 'Edward Titchener' 'Wilhelm Wundt'};

s = [s0 s1 s3 s4 s5 s9 s10];
p = [p0 p1 p3 p4 p5 p9 p10];

C1 = addedge(C1,p,s);

% Dewey: Loewenstein
s0 = {'George Loewenstein' 'George Loewenstein' 'George Loewenstein'};
p0 = {'Robert Abelson' 'Richard Levin' 'Sidney Winter'};

s1 = {'Richard Levin' 'Richard Levin' 'Richard Nelson' 'Richard Nelson' 'Richard Nelson'};
p1 = {'Joseph Stiglitz (2001)' 'Richard Nelson' 'William Fellner' 'Henry Bruton' 'James Tobin (1981)'};

s2 = {'Sidney Winter'};
p2 = {'William Fellner'};

s3 = {'Robert Abelson' 'Robert Abelson' 'John Tukey'};
p3 = {'Silvan Tomkins' 'John Tukey' 'Solomon Lefschetz'};

s4 = {'Wesley Cohen' 'Wesley Cohen' 'Wesley Cohen'};
p4 = {'Sidney Winter' 'Richard Nelson' 'Richard Levin'};

s = [s0 s1 s2 s3 s4];
p = [p0 p1 p2 p3 p4];

C1 = addedge(C1,p,s);

s = {'Mark Gertler' 'Duncan Foley' 'Duncan Foley' 'Herbert Scarf' 'Solomon Bocher'};
p = {'Duncan Foley' 'Herbert Scarf' 'James Tobin (1981)' 'Solomon Bocher' 'Erhard Schmidt'};

C1 = addedge(C1,p,s);

% Klein: Taylor
s = {'John Taylor' 'Theodore Anderson' 'Samuel Wilks' 'Samuel Wilks' 'Henry Rietz' 'George Miller' 'Frank Cole'};
p = {'Theodore Anderson' 'Samuel Wilks' 'Everett Lindquist' 'Henry Rietz' 'George Miller' 'Frank Cole' 'Felix Klein'};

C1 = addedge(C1,p,s);

% Kuznets: Goldin
%s = {'Claudia Goldin'};
%p = {'Robert Fogel (1993)'};

%C30 = addedge(C29,p,s);

% Ehrenfest: Juselius
s0 = {'Katarina Juselius' 'Johan Olof Fellman' 'Gustav Elfving' 'Rolf Nevanlinna' 'Rolf Nevanlinna'};
p0 = {'Johan Olof Fellman' 'Gustav Elfving' 'Rolf Nevanlinna' 'Ernst Lindelof' 'Gunnar Nordstrom'};

s1 = {'Gunnar Nordstrom' 'Gunnar Nordstrom' 'Gunnar Nordstrom' 'Gunnar Nordstrom'};
p1 = {'Hermann Minkowsky' 'Hjallmar Tallqvist' 'Albert Einstein' 'Paul Ehrenfest'};

s2 = {'Hermann Minkowsky' 'Hjallmar Tallqvist' 'Edvard Neovius' 'Hermann Schwarz' 'Hermann Schwarz'};
p2 = {'Ferdinand Lindemann' 'Edvard Neovius' 'Hermann Schwarz' 'Karl Weierstrass' 'Ernst Kummer'};

s3 = {'Albert Einstein' 'Albert Einstein'};
p3 = {'Aurel Stodola' 'Alfred Kleiner'};

s = [s0 s1 s2 s3];
p = [p0 p1 p2 p3];

C1 = addedge(C1,p,s);

% Orphans: Kreps  Dickey, Fuller
s0 = {'David Kreps' 'Evan Porteus'};
p0 = {'Evan Porteus' 'William Pierskalla'};

s1 = {'Daniel Levinthal'};
p1 = {'James March'};

s2 = {'David Dickey' 'Wayne Fuller'};
p2 = {'Wayne Fuller' 'Geoffrey Shepherd'};

s3 = {'Soren Johansen' 'Soren Johansen' 'Anders Hald' 'Georg Rasch' 'Georg Rasch'};
p3 = {'Hans Brons' 'Anders Hald' 'Georg Rasch' 'Niels Norlund' 'Niels Nielsen'};

s5 = {'Richard Posner'};
p5 = {'William Brennan'};

s = [s0 s1 s2 s3 s5];
p = [p0 p1 p2 p3 p5];

C1 = addedge(C1,p,s);

%% Diseased and others
s0 = {'Halbert White' 'Halbert White'};
p0 = {'Robert Solow (1987)' 'Jerry Hausman'};

s1 = {'Martin Weitzman' 'Anthony Atkinson'};
p1 = {'Robert Solow (1987)' 'Robert Solow (1987)'};

s2 = {'Gordon Tullock' 'Henry Simons'};
p2 = {'Henry Simons' 'Frank Knight'};

s4 = {'Alan Krueger' 'Alan Krueger'};
p4 = {'Lawrence Summers' 'Richard Freeman'};

s5 = {'Frank Ramsey'};
p5 = {'John Maynard Keynes'};

s6 = {'Alberto Alesina' 'Jeffrey Sachs'};
p6 = {'Jeffrey Sachs' 'Martin Feldstein'};

s7 = {'Anthony Downs' 'Jean-Jacques Laffont' 'Jean-Jacques Laffont'};
p7 = {'Kenneth Arrow (1972)' 'Kenneth Arrow (1972)' 'Jerry Green'};

s8 = {'Fischer Black' 'Patrick Fischer' 'Hartley Rogers' 'Alonzo Church'};
p8 = {'Patrick Fischer' 'Hartley Rogers' 'Alonzo Church' 'Oswald Veblen'};

s9 = {'Edith Penrose' 'Francine Blau' 'Francine Blau' 'Tim Bollerslev'};
p9 = {'Fritz Machlup' 'Peter Doeringer' 'Richard Freeman' 'Robert Engle (2003)'};

s11 = {'Robert Vishny' 'Robert Vishny' 'John Campbell'};
p11 = {'Franklin Fisher' 'Eric Maskin (2007)' 'Robert Shiller (2013)'};

s = [s0 s1 s2 s4 s5 s6 s7 s8 s9 s11];
p = [p0 p1 p2 p4 p5 p6 p7 p8 p9 p11];

C1 = addedge(C1,p,s);

C1 = addnode(C1,{'Ester Boserup'});
C1 = addnode(C1,{'William Meckling'});
C1 = addnode(C1,{'William Phillips' 'Don Patinkin' 'Janos Kornai' 'Michal Kalecki' 'Ralph Hawtrey'});

s0 = {'Jacob Mincer' 'Jacob Mincer' 'Harold Barger'};
p0 = {'George Stigler (1982)' 'Harold Barger' 'Noel Hall'};

s1 = {'Amos Tversky' 'Amos Tversky' 'Ward Edwards' 'Ward Edwards' 'Frederick Mosteller' 'Frederick Mosteller'};
p1 = {'Ward Edwards' 'Clyde Coombs' 'Frederick Mosteller' 'John Beebe-Center' 'Samuel Wilks' 'John Tukey'};

s2 = {'John Beebe-Center' 'Edwin Boring'};
p2 = {'Edwin Boring' 'Edward Titchener'};

s3 = {'Clyde Coombs' 'Clyde Coombs' 'Edward Tolman' 'Edward Tolman' 'Hugo Muensterberg' 'Edwin Holt'  'Edwin Holt'};
p3 = {'Edward Tolman' 'Louis Thurstone' 'Edwin Holt' 'Hugo Muensterberg' 'Wilhelm Wundt' 'Hugo Muensterberg' 'William James'};

s4 = {'William James' 'William James' 'William James'};
p4 = {'Charles Peirce' 'Jeffries Wyman' 'Louis Agassiz'};

s5 = {'Louis Thurstone' 'Louis Thurstone' 'Louis Thurstone'};
p5 = {'Thomas Edison' 'Walter Bingham' 'James R. Angell'};

s = [s0 s1 s2 s3 s4 s5];
p = [p0 p1 p2 p3 p4 p5];

C1 = addedge(C1,p,s);

%2021 citation laureates
%Rogoff added above
s0 = {'Carmen Reinhart'};
p0 = {'Robert Mundell (1999)'};

s1 = {'Deirdre McCloskey' 'Joel Mokyr (2025)' 'William Parker' 'William Parker' 'Alexander Gerschenkron' 'Abbott Usher' 'Edwin Gay'};
p1 = {'Alexander Gerschenkron' 'William Parker' 'Alexander Gerschenkron' 'Abbott Usher' 'Hans Mayer' 'Edwin Gay' 'Gustav von Schmoller'};

s2 = {'David Teece' 'Edwin Mansfield' 'Frank Hanna' 'Harold Groves' 'Walter Heller'};
p2 = {'Edwin Mansfield' 'Frank Hanna' 'Harold Groves' 'John Commons' 'Harold Groves'};

s3 = {'David Audretsch' 'Leonard Weiss'};
p3 = {'Leonard Weiss' 'George Stigler (1982)'};

s4 = {'Alan Krueger' 'Larry Katz' 'Henry Farber'};
p4 = {'Larry Katz' 'Henry Farber' 'Orley Ashenfelter'};

s5 = {'Henri Theil' 'Henri Theil' 'Guillermo Calvo'};
p5 = {'Pieter de Wolff' 'Pieter Hennipman' 'Tjalling Koopmans (1975)'};

s6 = {'Sanford Grossman' 'Arnold Zellner'};
p6 = {'Arnold Zellner' 'George Kuznets'};

s7 = {'Pieter Hennipman' 'Herman Frijda' 'Hendrik Greven' 'Simon Vissering' 'Simon Vissering'};
p7 = {'Herman Frijda' 'Hendrik Greven' 'Simon Vissering' 'Cornelis van Assen' 'Johan Thorbecke'};

s8 = {'Cornelis van Assen' 'Hendrik Tydeman' 'Dionysius van der Keessel' 'Gerlach Scheltinga'};
p8 = {'Hendrik Tydeman' 'Dionysius van der Keessel' 'Gerlach Scheltinga' 'Abraham Wieling'};

s9 = {'Johan Thorbecke' 'Johan Thorbecke' 'Johannes van Voorst' 'Johannes Schultens'};
p9 = {'David van Lennep' 'Johannes van Voorst' 'Johannes Schultens' 'Albert Schultens'};

s10 = {'David van Lennep' 'Hendrik Cras' 'Hendrik Cras' 'Hendrik Cras'};
p10 = {'Hendrik Cras' 'Elie Luzac' 'Gerlach Scheltinga' 'Johann Rucker'};

s = [s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 s10];
p = [p0 p1 p2 p3 p4 p5 p6 p7 p8 p9 p10];

C1 = addedge(C1,p,s);

C1 = addnode(C1,{'Kelvin Lancaster' 'Richard Layard'});

s0 = {'Roy Harrod'};
p0 = {'John Maynard Keynes'};

s1 = {'Mancur Olson'};
p1 = {'Thomas Schelling (2005)'};

s2 = {'Richard Easterlin'};
p2 = {'Simon Kuznets (1971)'};

s3 = {'Andrew Oswald' 'Arthur Smithies' 'John Enos' 'Morris Adelman' 'Edward Mason'};
p3 = {'David Soskice' 'John Enos' 'Morris Adelman' 'Edward Mason' 'Frank Taussig'};

s4 = {'Samuel Bowles' 'Samuel Bowles' 'Arthur MacEwan' 'Arthur MacEwan'};
p4 = {'Arthur MacEwan' 'Hollis Chenery' 'Hollis Chenery' 'Wassily Leontief (1973)'};

s5 = {'Herbert Gintis'};
p5 = {'Arthur Smithies'};

s = [s0 s1 s2 s3 s4 s5];
p = [p0 s1 p2 p3 p4 p5];

C1 = addedge(C1,p,s);

%%
s0 = {'Susan Athey' 'Susan Athey' 'Susan Athey'};
p0 = {'Paul Milgrom (2020)' 'Donald J. Roberts' 'Edward Lazear'};

s1 = {'Donald J. Roberts' 'Hugo F. Sonnenschein'};
p1 = {'Hugo F. Sonnenschein' 'Stanley Reiter'};

s2 = {'Robert Dorfman' 'Robert Dorfman' 'Irma Adelman'};
p2 = {'William Fellner' 'Aaron Gordon' 'Robert Dorfman'};

s3 = {'Emmanuel Saez' 'Emmanuel Saez' 'James Poterba'};
p3 = {'Peter Diamond (2010)' 'James Poterba' 'W.M. Gorman'};

s4 = {'George Dantzig' 'Jerzy Neyman' 'Waclaw Sierpinski' 'Waclaw Sierpinski'};
p4 = {'Jerzy Neyman' 'Waclaw Sierpinski' 'Georgy Voronoy' 'Stanislaw Zaremba'};

s5 = {'Georgy Voronoy' 'Andrei Markov' 'Stanislaw Zaremba'};
p5 = {'Andrei Markov' 'Pafnuty Chebyshev' 'Gaston Darboux'};

s6 = {'Abram Bergson' 'Alan Manne' 'Alan Manne'};
p6 = {'Wassily Leontief (1973)' 'Wassily Leontief (1973)' 'Edward Mason'};

s7 = {'Hans-Werner Sinn' 'Hans-Werner Sinn' 'Hans Heinrich Nachtkamp' 'Herbert Timm' 'Heinz Konig' 'Louis Zimmermann' 'Louis Zimmermann'};
p7 = {'Heinz Konig' 'Hans Heinrich Nachtkamp' 'Herbert Timm' 'Rudolf Stucken' 'Louis Zimmermann' 'Jan Tinbergen (1969)' 'Theodore Limperg'};

s8 = {'Guido Tabellini' 'David Levine'};
p8 = {'David Levine' 'Peter Diamond (2010)'};

s9 = {'Michelle Tertilt' 'Michelle Tertilt' 'Michelle Boldrin' 'Larry Jones' 'Larry Jones' 'Andreu Mas-Colell' 'Edgar Brown'};
p9 = {'Michelle Boldrin' 'Larry Jones' 'Lionel McKenzie' 'Gerard Debreu (1983)' 'Andreu Mas-Colell' 'Edgar Brown' 'Alvin Hansen'};

s10 = {'George Shackle' 'George Shackle'};
p10 = {'Friedrich Hayek (1974)' 'Henry Brown'};

s = [s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 s10];
p = [p0 p1 p2 p3 p4 p5 p6 p7 p8 p9 p10];

C1 = addedge(C1,p,s);

%%
s0 = {'Tibor Scitovsky' 'Tibor Scitovsky' 'Sidney Weintraub' 'Sidney Weintraub' 'Sidney Weintraub'};
p0 = {'Lionel Robbins' 'Friedrich Hayek (1974)' 'Lionel Robbins' 'Herbert Dorau' 'Marcus Nadler'};

s1 = {'Robert Triffin' 'Robert Triffin' 'Edward Chamberlin'};
p1 = {'Wassily Leontief (1973)' 'Edward Chamberlin' 'Allyn Abbott Young'};

s2 = {'John van Reenen' 'John van Reenen' 'Stephen Machin' 'Nicholas Bloom' 'Nicholas Bloom'};
p2 = {'Richard Blundell' 'Stephen Machin' 'Mark Stewart' 'Richard Blundell' 'John van Reenen'};

s3 = {'Jaroslav Vanek' 'Helene Rey' 'Fabrizio Zilibotti' 'Charles Bean'};
p3 = {'Charles Kindleberger' 'Charles Bean' 'Charles Bean' 'Robert Solow (1987)'};

s4 = {'Gilles Saint-Paul' 'Gilles Saint-Paul' 'Michael Piore' 'Walt Rostow'};
p4 = {'Olivier Blanchard' 'Michael Piore' 'John Dunlop' 'Arthur Gayer'};

s5 = {'Kenneth Boulding' 'Kenneth Boulding' 'Kenneth Boulding' 'Kenneth Boulding'};
p5 = {'Lionel Robbins' 'Joseph Schumpeter' 'Frank Knight' 'Henry Schultz'};

s6 = {'Marc Nerlove' 'Carl Christ' 'Carl Christ' 'Steven Levitt'};
p6 = {'Carl Christ' 'Jacob Marschak' 'Tjalling Koopmans (1975)' 'James Poterba'};

s7 = {'Harry Brown' 'Irving Fisher' 'Irving Fisher' 'Willard Gibbs'};
p7 = {'Irving Fisher' 'William Sumner' 'Willard Gibbs' 'Hubert Newton'};

s8 = {'Silvana Tenreyro' 'Silvana Tenreyro' 'Silvana Tenreyro' 'Partha Dasgupta'};
p8 = {'Alberto Alesina' 'Kenneth Rogoff' 'Robert Barro' 'James Mirrlees (1996)'};

s9 = {'Gregory Mankiw' 'Imran Rasul' 'Timothy Besley'};
p9 = {'Ricardo Reis' 'Timothy Besley' 'W.M. Gorman'};

s10 = {'Joe Bain' 'Joe Bain' 'Joe Bain'};
p10 = {'Edward Chamberlin' 'Joseph Schumpeter' 'Edward Mason'};

s11 = {'Oriana Bandiera' 'Oriana Bandiera' 'Fabio Schiantarelli' 'James Anderson' 'Robert Baldwin'};
p11 = {'Fabio Schiantarelli' 'James Anderson' 'Stephen Nickell' 'Robert Baldwin' 'Gottfried Haberler'};

s = [s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11];
p = [p0 p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11];

C1 = addedge(C1,p,s);

%%
s0 = {'Amy Finkelstein' 'Amy Finkelstein' 'Jonathan Gruber' 'Raj Chetty'};
p0 = {'James Poterba' 'Jonathan Gruber' 'Larry Katz' 'Martin Feldstein'};

s1 = {'Roland Fryer' 'Tomas Sjostrom' 'William Thomson' 'Mordecai Kurz'};
p1 = {'Tomas Sjostrom' 'William Thomson' 'Mordecai Kurz' 'Edmund Phelps (2006)'};

s2 = {'Philipp Strack' 'Paul Heidhues' 'Paul Heidhues' 'James Brown'};
p2 = {'Paul Heidhues' 'Suchan Chae' 'James Brown' 'Gary Becker (1992)'};

s3 = {'Torsten Persson' 'Lars Svensson'};
p3 = {'Lars Svensson' 'Lars Werin'};

s4 = {'Yuliy Sannikov' 'Yuliy Sannikov' 'Andrzej Skrzypacz' 'Hugo Hopenhayn'};
p4 = {'Robert Wilson (2020)' 'Andrzej Skrzypacz' 'Hugo Hopenhayn' 'Edward Prescott (2004)'};

s5 = {'Dave Donaldson' 'Dave Donaldson' 'Robin Burgess'};
p5 = {'Timothy Besley' 'Robin Burgess' 'Timothy Besley'};

s6 = {'Parag Pathak' 'Parag Pathak' 'Melissa Dell' 'Melissa Dell' 'Benjamin Olken'};
p6 = {'Alvin Roth (2012)' 'Jean Tirole (2014)' 'Daron Acemoglu (2024)' 'Benjamin Olken' 'Michael Kremer (2019)'};

s7 = {'Isaiah Andrews' 'Anna Mikusheva' 'James Stock' 'Thomas Rothenberg'};
p7 = {'Anna Mikusheva' 'James Stock' 'Thomas Rothenberg' 'Franklin Fisher'};

s8 = {'Oleg Itskhoki' 'Oleg Itskhoki' 'Oleg Itskhoki' 'Oleg Itskhoki' 'Pol Antras'};
p8 = {'Elhanan Helpman' 'Gita Gopinath' 'Aleh Tsyvinski' 'Pol Antras' 'Daron Acemoglu (2024)'};

s9 = {'Aleh Tsyvinski' 'Narayana Kocherlakota' 'Gita Gopinath' 'Gita Gopinath' 'Edward Glaeser'};
p9 = {'Narayana Kocherlakota' 'Jose Scheinkman' 'Kenneth Rogoff' 'Ben Bernanke (2022)' 'Jose Scheinkman'};

s10 = {'Gabriel Zucman' 'Thomas Piketty' 'Roger Guesnerie'};
p10 = {'Thomas Piketty' 'Roger Guesnerie' 'Jean-Jacques Laffont'};

s11 = {'Bronwyn Hall' 'Timothy Bresnahan' 'Richard Quandt' 'Robert Porter'};
p11 = {'Timothy Bresnahan' 'Richard Quandt' 'Wassily Leontief (1973)' 'Richard Quandt'};

s12 = {'Kalina Manova' 'Kalina Manova' 'Kalina Manova' 'Kalina Manova'};
p12 = {'Elhanan Helpman' 'Marc Melitz' 'Philippe Aghion (2025)' 'Pol Antras'};

s = [s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 s12];
p = [p0 p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12];

C1 = addedge(C1,p,s);

%%
s0 = {'Janet Currie' 'Janet Currie' 'Paolo Mauro' 'Albert Hirschman'};
p0 = {'David Card (2021)' 'Orley Ashenfelter' 'Andrei Shleifer' 'Pierpaolo Fegiz'};

s1 = {'Walter Isard' 'Walter Isard' 'Walter Isard' 'Walter Isard' 'Walter Isard' 'Oskar Lange'};
p1 = {'Alvin Hansen' 'Frank Knight' 'Jacob Viner' 'Abbott Usher' 'Oskar Lange' 'Adam Krzynanowksi'};

s2 = {'Richard Musgrave' 'Evsey Domar'};
p2 = {'Alvin Hansen' 'Alvin Hansen'};

s3 = {'Edmond Malinvaud' 'Edmond Malinvaud' 'Botond Koszegi'};
p3 = {'Maurice Allais (1988)' 'Eugene Morice' 'Peter Diamond (2010)'};

s4 = {'Harvey Leibenstein' 'Frank Notestein' 'Axel Leijonhufvud' 'Robert Clower'};
p4 = {'Frank Notestein' 'W.F. Wilcox' 'Robert Clower' 'John Hicks (1972)'};

s5 = {'Lars Werin' 'Lars Werin' 'Lars Werin' 'Assar Lindbeck' 'Assar Lindbeck' 'Johan Akerman' 'Erik Lundberg' 'Ingvar Svennilson'};
p5 = {'Johan Akerman' 'Erik Lundberg' 'Ingvar Svennilson' 'Erik Lundberg' 'Ingvar Svennilson' 'Karl Gustav Cassel' 'Karl Gustav Cassel' 'Gunnar Myrdal (1974)'};

s6 = {'Ian Little' 'Ian Little' 'Ian Little' 'Hollis Chenery'};
p6 = {'John Hicks (1972)' 'Arthur Lewis (1979)' 'David Worswick' 'Wassily Leontief (1973)'};

s7 = {'Paul Douglas' 'John Maurice Clark' 'John Maurice Clark'};
p7 = {'Edwin Seligman' 'Edwin Seligman' 'John Bates Clark'};

s8 = {'Jan de Loecker' 'Jozef Konings'};
p8 = {'Jozef Konings' 'Christopher Pissarides (2010)'};

s9 = {'Edward Denison' 'Philip Taft' 'Selig Perlman' 'Selig Perlman' 'Selig Perlman' 'Frederic Turner'};
p9 = {'Philip Taft' 'Selig Perlman' 'Richard Ely' 'John Commons' 'Frederic Turner' 'Herbert Adams'};

s10 = {'Mathias Dewatripont' 'Mathias Dewatripont'};
p10 = {'Eric Maskin (2007)' 'Andreu Mas-Colell'};

s11 = {'Nicholas Georgescu-Roegen' 'Nicholas Georgescu-Roegen' 'Nicholas Georgescu-Roegen'};
p11 = {'Joseph Schumpeter' 'Karl Pearson' 'Emile Borel'};

s12 = {'Kenneth Galbraith' 'George Peterson' 'John Black'};
p12 = {'George Peterson' 'John Black' 'Benjamin Hibbard'};

s13 = {'Jacques Dreze' 'Maurice Dobb' 'Maurice Dobb'};
p13 = {'William Vickrey (1996)' 'Edwin Cannan' 'Hugh Dalton'};

s = [s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 s12 s13];
p = [p0 p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13];

C1 = addedge(C1,p,s);
%%
s = {'Jonathan Levin'};
p = {'Bengt Holmstrom (2016)'};

C1 = addedge(C1,p,s);

%%
s = {'Sendhil Mullainathan' 'Sendhil Mullainathan' 'Sendhil Mullainathan'};
p = {'Drew Fudenberg' 'Larry Katz' 'Andrei Shleifer'};

C1 = addedge(C1,p,s);

s = {'Marianne Bertrand' 'David Autor'};
p = {'Larry Katz' 'Larry Katz'};

C1 = addedge(C1,p,s);

s0 = {'Julia Cage' 'Julia Cage' 'Julia Cage'};
p0 = {'Nathan Nunn' 'Andrei Shleifer' 'Alberto Alesina'};

s1 = {'Nathan Nunn' 'Nathan Nunn' 'Martin Osborne'};
p1 = {'Martin Osborne' 'Daniel Trefler' 'Mordecai Kurz'};

s2 = {'Daniel Trefler' 'Daniel Trefler' 'John Riley'};
p2 = {'Edward Leamner' 'John Riley' 'Robert Solow (1987)'};

s3 = {'Edward Leamner' 'Edward Leamner' 'Aaron Gordon' 'William Ericson'};
p3 = {'Saul Hymans' 'William Ericson' 'Saul Hymans' 'Howard Raiffa'};

s4 = {'David Yanagizawa-Drott' 'Jakob Svensson'};
p4 = {'Jakob Svensson' 'Torsten Persson'};

s = [s0 s1 s2 s3 s4];
p = [p0 p1 p2 p3 p4];

C1 = addedge(C1,p,s);

s = {'Matthew Jackson' 'Matthew Jackson' 'Dilip Mookherjee' 'Darryl Duffie' 'David Luenberger' 'William Linvill' 'Ernst Guillemin' 'Ernst Guillemin'};
p = {'Dilip Mookherjee' 'Darryl Duffie' 'Partha Dasgupta' 'David Luenberger' 'William Linvill' 'Ernst Guillemin' 'Arnold Sommerfeld' 'Vannevar Bush'};

C1 = addedge(C1,p,s);

s = {'Michael Woodford' 'Michael Woodford' 'Timothy Kehoe' 'Timothy Kehoe'};
p = {'Robert Solow (1987)' 'Timothy Kehoe' 'Andreu Mas-Colell' 'Herbert Scarf'};

C1 = addedge(C1,p,s);

%%
hfig = figure;
if names
    plot(C1,'Layout',layout,'NodeLabel',C1.Nodes.Name);
else
     plot(C1,'Layout',layout,'NodeLabel',{});
end
title('Candidates');
set(gcf,'units','points','position',[0,0,960,720])
xticklabels({}); yticklabels({});xticks([]);yticks([]);