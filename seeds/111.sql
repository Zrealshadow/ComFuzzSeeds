select '((a <2> c) & (b <-> c)) <-> d'::tsquery @@ 'a:1 b:2 c:3 d:4';
select '((a <2> c)) <-> d'::tsquery @@ 'a:1 b:2 c:3 d:4';
select '((b <-> c)) <-> d'::tsquery @@ 'a:1 b:2 c:3 d:4';
