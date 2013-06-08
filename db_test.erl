c(db).
f().
Db = db:new().
Db1 = db:write(a,1, Db).
Db2 = db:write(b,2, Db1).
Db3 = db:write(c,3, Db2).
Db4 = db:write(d,4, Db3).
Db5 = db:write(e,4, Db4).
Db6 = db:write(f,6, Db5).
Db7 = db:write(g,7, Db6).
Db8 = db:write(h,8, Db7).
Db9 = db:write(h,9, Db8).
Db10 = db:write(i,10, Db9).
db:delete(a,Db10).
db:delete(b,Db10).
db:delete(c,Db10).
db:delete(d,Db10).
db:delete(h,Db10).
db:delete(i,Db10).
db:read(a, Db10).
db:read(d, Db10).
db:read(unknown, Db10).
db:read(f, Db10).
db:read(h, Db10).
db:read(what, Db10).
db:match(1,Db10).
db:match(4,Db10).
db:match(8,Db10).
db:match(10,Db10).
f().
Db = db:new().
Db1 = db:write(a,1, Db).
Db2 = db:write(b,2, Db1).
Db3 = db:write(a,3, Db2).


c(db).
f().
db:merge([1,2],[3,4]).
db:merge([1,2],[3,4,5]).
db:merge([1,2],[3,4,5,6]).
db:merge([1,2,3],[4,5]).
db:merge([1,2,3,4],[5,6]).

c(db).
f().
db:delete(a,[{a,1},{b,2},{c,3},{d,4},{e,4},{f,6},{g,7},{h,8}]).
db:delete(b,[{a,1},{b,2},{c,3},{d,4},{e,4},{f,6},{g,7},{h,8}]).
db:delete(c,[{a,1},{b,2},{c,3},{d,4},{e,4},{f,6},{g,7},{h,8}]).
db:delete(g,[{a,1},{b,2},{c,3},{d,4},{e,4},{f,6},{g,7},{h,8}]).
db:delete(h,[{a,1},{b,2},{c,3},{d,4},{e,4},{f,6},{g,7},{h,8}]).

