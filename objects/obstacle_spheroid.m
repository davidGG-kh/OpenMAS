%% CUBOID OBSTACLE CLASS (obstacle_cuboid.m) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is an iteration on the original obstacle class, which defines a 3D
% cuboid in 3D space. The cube is defined by a centroid position and a
% series of vertices.

% Author: James A. Douthwaite 23/05/2018

classdef obstacle_spheroid < obstacle
    properties
    end
    %% ///////////////////////// MAIN METHODS /////////////////////////////
    methods 
        % Constructor
        function [this] = obstacle_spheroid(varargin)
            % This function constructs the cuboid obstacle. The object must
            % be imported and represented with a global position and
            % velocity as all other objects are in OMAS.
                        
            % Call the super class
            this = this@obstacle(varargin); 

            % Assign defaults
            this.SetGLOBAL('hitBoxType',OMAS_hitBoxType.spherical); % Spherical collider
            
            % CONSTRUCT THE GEOMETRY FROM DEFINITION INSTEAD
            if size(this.GEOMETRY.vertices,1) < 1  % If it has no geometry define it
                [this.GEOMETRY] = OMAS_graphics.defineSphere(zeros(3,1),this.radius,20);
            end

            % //////////////// Check for user overrides ///////////////////
            this = this.ApplyUserOverrides(varargin); % Recursive overrides
            % /////////////////////////////////////////////////////////////
        end    

        % COMPUTE CLOSEST FACE TO POINT
        function [d,faceID] = faceClosestToPoint(obj,patchObj,p) 
            
            d = inf;
            for f = 1:size(patchObj.faces,1)
                face = patchObj.faces(f,:);
                facePoints = patchObj.vertices(face,:);     
                
                [dtemp] = obj.distanceFromPlane(facePoints,p); % Distance from face
                
                if dtemp < d && dtemp > 0
                    d = dtemp;      % The current seperation
                    faceID = f;     % The face index
                elseif dtemp == d
                    faceID = vertcat(faceID,f);
                end
            end
        end
    end
    methods (Static)
        % CALCULATE CLOSET POINT ON SEGMENT TO POINT
        function [pClosest] = closestPointOnSegment(pA,pB,q)
            % https://diego.assencio.com/?index=ec3d5dfdfc0b6a0d147a656f0af
            % 332bd#mjx-eqn-post_ec3d5dfdfc0b6a0d147a656f0af332bd_lambda_closest_point_line_to_point
            
            lambda = dot(q - pA,pB - pA)/dot(pB - pA,pB - pA);
            
            if lambda <= 0                          % The point is before the line starts
                pClosest = pA;
            elseif lambda >= 1                      % The point is after the line ends
                pClosest = pB;
            else
                pClosest = pA + lambda*(pB - pA);   % The point is mid-way between
            end
        end
        % CALCULATE DISTANCE FROM FACE
        function [d,N] = distanceFromPlane(FV,p)
            % Calculate the distance between an arbitrary point and given
            % face plane.
            e1 = FV(2,:) - FV(1,:);
            e2 = FV(3,:) - FV(1,:);
            % Face- normal
            N = cross(e1,e2);
            unitN = N/norm(N);
            % Projection against the face normal
            d = dot(unitN,p'); % +ve if in the same direction
         end     
    end
end
