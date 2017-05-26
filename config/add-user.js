db.getSiblingDB("$external").runCommand(
  {
    createUser: "CN=somemongoclient,O=Test,L=Arlington,ST=VA,C=US",
    roles: [
             { role: 'readWrite', db: 'test' },
             { role: 'userAdminAnyDatabase', db: 'admin' }
           ],
    writeConcern: { w: "majority" , wtimeout: 5000 }
  }
)
