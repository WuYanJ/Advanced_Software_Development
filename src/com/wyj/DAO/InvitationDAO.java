package com.wyj.DAO;

import com.wyj.Model.TravelUser;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class InvitationDAO extends DAO {
    // 未同意
    public List<TravelUser> getInvitationSenders(String username) throws SQLException {
        List<TravelUser> invitationSenders = new ArrayList<>();
        String sql = "SELECT fromUser FROM travels.invitation WHERE toUser=? AND status=1";
        List<String> invitationSenderNames = getForValueList(sql, username);
        sql = "SELECT uid, email, username, pass password, state, dateJoined, dateLastModified FROM travels.traveluser WHERE username=?";
        for (String name: invitationSenderNames){
            TravelUser user = get(TravelUser.class, sql, name);
            invitationSenders.add(user);
        }
        return invitationSenders;
    }
}
