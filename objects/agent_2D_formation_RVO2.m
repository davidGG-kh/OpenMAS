
% Author: James A. Douthwaite

classdef agent_2D_formation_RVO2 < agent_2D_formation_RVO & agent_2D_RVO2
%% INITIALISE THE AGENT SPECIFIC PARAMETERS
    properties
        % PROPERTITIES UNIQUE TO AGENT CLASS
    end
    %% ///////////////////////// MAIN METHODS /////////////////////////////
    methods 
        % Constructor
        function obj = agent_2D_formation_RVO2(varargin)
            % CALL THE SUPERCLASS CONSTRUCTOR
            obj = obj@agent_2D_formation_RVO(varargin);
            
            % //////////////// Check for user overrides ///////////////////
            [obj] = obj.ApplyUserOverrides(varargin); % Recursive overrides
            % /////////////////////////////////////////////////////////////
        end 
        % NOTES:
        % This class simply overrides the 'process_timeCycle' function of
        % the superclass 'agent_2D_formation_RVO' such that it considers the
        % 'avoidanceCorrection' of the second super class 'agent_2D_RVO2'. 
    end
end