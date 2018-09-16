module PapersHelper

    def p1_clause_1(paper, current_user)    
        if paper.team_id ==0 and paper.role_id == 1 and current_user.roles.last.id < 6
            return true 
        elsif current_user.roles.last.id == 4 or current_user.roles.last.id == 5 or current_user.roles.last.id == 3
            return true
        elsif paper.team_id == current_user.roles.last.id
            return true
        elsif current_user.roles.last.id == 1 or current_user.roles.last.id == 2
            return true
        elsif paper.role_id == 3 and current_user.roles.last.id > 5
            return true
        else
            return false 
        end
    end

    def p1_clause_2(current_user)
        if current_user.roles.last.id <3
           return true 
        else
            return false 
        end
    end

    def p2_clause(paper, current_user)
        if current_user.roles.last.id = paper.team_id and current_user.has_role? :TeamAdmin or current_user.has_role? :leader
            return true
        else
            return false
        end
    end

    def p3_clause(paper, current_user)
        if paper.team_id = 0 and current_user.has_role? :TeamAdmin
            return true
        else
            return false
        end
    end



end
