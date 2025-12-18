package dao;

import db.JdbiConnector;
import org.jdbi.v3.core.Jdbi;

public abstract class ADAO {
    protected Jdbi jdbi = JdbiConnector.get();
}
