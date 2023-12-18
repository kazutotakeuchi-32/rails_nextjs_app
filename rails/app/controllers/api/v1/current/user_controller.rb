# frozen_string_literal: true

module Api
  module V1
    module Current
      class UserController < Api::V1::BaseController
        before_action :authenticate_user!, only: [:me]

        def me
          render json: current_user, serializer: CurrentUserSerializer, status: 200
        end
      end
    end
  end
end

# curl -X GET  -H 'access-token: MA8YjETIivLjhNnJ3cY3Ww'  -H 'client: U1MM4r-nYB7MitOids8pCw'  -H 'expiry: 1703741475' http://localhost:3000/api/v1/current/user/1
# curl -X GET -H 'access-token:G9VvSZQ94p9MgA_K3JTAyA' -H 'client:JCVFx88rKY1ke27sTOuU8g' -H 'expiry:1703742288' -h 'uid:test1@example.com' http://localhost:3000/api/v1/current/user/1
